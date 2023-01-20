import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/comment_order.dart';

class CommentService {
  static CommentService get instance => _instance ??= CommentService();
  static CommentService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('comments');

  DocumentReference doc(String category) => col.doc(category);

  /// Returns the snapshot of comemnt list of the post.
  ///
  /// Use this to list the comments on post view screen.
  Stream<QuerySnapshot<Object?>> children(String postId) {
    return CommentService.instance.col
        .where('postDocumentReference',
            isEqualTo: PostService.instance.doc(postId))
        .snapshots();
  }

  afterCreate({required DocumentReference commentDocumentReference}) async {
    final comment =
        CommentModel.fromSnapshot(await commentDocumentReference.get());
    final post =
        PostModel.fromSnapshot(await comment.postDocumentReference.get());

    CommentModel? parent;
    if (comment.parentCommentDocumentReference != null) {
      parent = CommentModel.fromSnapshot(
          await comment.parentCommentDocumentReference!.get());
    }

    final categoryDoc = CategoryService.instance.doc(post.category);
    // update comment
    // add category of the post, update `order` field.
    await commentDocumentReference.update({
      'category': post.category,
      'order': commentOrder(parent?.order, parent?.depth, post.noOfComments),
      'depth': parent?.depth ?? 0 + 1,
    });

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // increase on of comments in category docuemnt, user doucment, post document

// TODO update no of comments on user document
    await categoryDoc.update(
      {
        'noOfComment': FieldValue.increment(1),
      },
    );

    if (AppService.instance.supabase) {
      await supabase.comments.insert(
        {
          'commentId': commentDocumentReference.id,
          'category': post.category,
          'postId': post.id,
          'uid': post.userDocumentReference.id,
          'created_at': comment.createdAt.toDate().toIso8601String(),
          'updated_at': comment.updatedAt.toDate().toIso8601String(),
          'content': comment.content,
        },
      );
    }
  }

  afterUpdate({required DocumentReference commentDocumentReference}) async {
    // update comment
    // updatedAt...

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // copy data into supabase.
  }
}
