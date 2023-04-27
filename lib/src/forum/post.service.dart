import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
// import 'package:fireflow/src/backend/schema/posts_record.dart';
// import 'package:collection/collection.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('posts');
  DocumentReference doc(String category) => col.doc(category);

  /// Get the post
  Future<PostModel> get(String id) async {
    final snapshot = await PostService.instance.doc(id).get();
    return PostModel.fromSnapshot(snapshot);
  }

  /// post create method
  Future<PostModel> create({
    required String categoryId,
    String title = '',
    String content = '',
    List<String> files = const [],
  }) async {
    late final DocumentReference postDocumentReference;

    // 글 생성
    try {
      final createData = PostModel.toCreate(
        categoryId: categoryId,
        title: title,
        content: content,
        files: files,
        wasPremiumUser: my.isPremiumUser,
      );

      postDocumentReference = await col.add(createData);
    } catch (e) {
      // 글 생성에 오류가 발생한 경우, 분명하게 오류 메시지를 전달한다. 그래야 해결이 쉽다.
      final exists = await CategoryService.instance.exists(categoryId);
      if (!exists) {
        throw Exception('The category [$categoryId] does not exist.');
      }

      rethrow;
    }

    final post = await get(postDocumentReference.id);
    final categoryDoc = CategoryService.instance.doc(post.categoryId);
    final category = CategoryModel.fromSnapshot(await categoryDoc.get());

    /// 게시판 별 구독한 사용자에게 푸시 알림 보냄
    ///
    /// 구독한 사용자 설정 목록을 가져 옴. (사용자 문서를 읽는 것은 아니지만, 읽기 이벤트가 많이 발생 할 수 있다.)
    final snapshot = await UserSettingService.instance.col
        .where('postSubscriptions', arrayContains: category.reference)
        .get();

    /// FF 방식의 게시판 별 구독한 사용자에게 푸시 알림을 위한 문서를 Firestore 에 생성.
    /// 즉, FF 의 푸시 알림 방식을 사용하므로, FF 의 Push Notification 설정이 되어져 있어야 한다.
    List<Future> futures = [];
    if (snapshot.size > 0) {
      final List<DocumentReference> userRefs = [];
      for (final doc in snapshot.docs) {
        final setting = UserSettingModel.fromSnapshot(doc);
        userRefs.add(setting.userDocumentReference);
      }

      futures.add(
        MessagingService.instance.send(
          notificationTitle: post.title.safe,
          notificationText: post.content.safe,
          notificationSound: 'default',
          notificationImageUrl: post.files.isNotEmpty ? post.files.first : null,
          userRefs: userRefs,
          initialPageName: 'PostView',
          parameterData: {'postDocumentReference': postDocumentReference},
        ),
      );
    }

    /// 글의 각종 기본 정보 업데이트.
    ///
    /// 특히, 글 id 는 글을 먼저 생성한 다음에 해야하는 것이고, 기타 글 생성 후 해야하는 것들이 있다.
    futures.add(
      postDocumentReference.update(PostModel.toUpdate(
        postDocumentReference: postDocumentReference,
        emphasizePremiumUserPost: category.emphasizePremiumUserPost,
      )),
    );

    // 카테고리에 글 1 증가
    futures.add(category.increaseNoOfPosts());

    /// 피드
    ///
    /// 사용자 컬렉션에 피드를 업데이트 한다.
    ///
    futures.add(
      UserService.instance.update(
        lastPost: UserService.instance.feed(post),
        recentPosts: UserService.instance.recentPosts(post),
        noOfPosts: FieldValue.increment(1),
        lastPostCreatedAt: FieldValue.serverTimestamp(),
      ),
    );

    /// Update the no of posts on system settings
    ///
    /// Note that, user cannot update system settings.
    /// futures.add(SystemSettingService.instance.increaseNoOfPosts());

    // 수파베이스에 글 저장 (검색 등에 활용)
    if (SupabaseService.instance.storePosts) {
      futures.add(
        supabase.posts.insert(
          {
            'post_id': postDocumentReference.id,
            'category_id': post.categoryId,
            'uid': my.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
        ),
      );
    }

    // 수파베이스에 글/코멘트 테이블에 저장 (검색 등에 활용)
    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.insert(
          {
            'id': postDocumentReference.id,
            'post_id': postDocumentReference.id,
            'category_id': post.categoryId,
            'uid': my.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
        ),
      );
    }

    await Future.wait(futures);

    return get(post.id);
  }

  /// 글 업데이트
  ///
  /// 주의, updatedAt 필드가 자동 설정되지 않는다.
  /// 혹시나, post listen 함수 내에서 post update 를 하면 재귀적으로 호출되기 때문에 미리 방지하기 위해서이다.
  Future update(DocumentReference postDocumentReference, data) async {
    await postDocumentReference.update(data);
  }

  /// 글 삭제
  ///
  Future delete(PostModel post) async {
    /// 코멘트가 있으면 삭제 표시
    if (post.noOfComments > 0) {
      await post.reference.update({
        'deleted': true,
      });
    } else {
      /// 코멘트가 없으면 삭제
      await post.reference.delete();
    }

    post.deleted = true;

    /// 나머지, 처리를 한번의 await 으로 처리
    List<Future> futures = [];

    /// 첨부 파일 삭제
    if (post.files.isNotEmpty) {
      for (final url in post.files) {
        futures.add(StorageService.instance.delete(url));
      }
      await Future.wait(futures);
    }

    // 사용자 글 수 1 감소
    futures.add(
      UserService.instance.update(
        noOfPosts: FieldValue.increment(-1),
      ),
    );

    // 카테고리 글 1 감소
    futures.add(
      CategoryService.instance.doc(post.categoryId).update(
        {
          'noOfPosts': FieldValue.increment(-1),
        },
      ),
    );

    /// 수파베이스에 글 테이블에서 삭제
    if (SupabaseService.instance.storePosts) {
      futures.add(supabase.posts.delete().eq('post_id', post.id));
    }

    /// 수파베이스에 글/코멘트 테이블에서 삭제
    if (SupabaseService.instance.storePosts) {
      futures.add(supabase.postsAndComments.delete().eq('post_id', post.id));
    }

    await Future.wait(futures);
  }
}
