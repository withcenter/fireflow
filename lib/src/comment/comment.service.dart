import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

class CommentService {
  static CommentService get instance => _instance ??= CommentService();
  static CommentService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('comments');
  DocumentReference doc(String category) => col.doc(category);

  afterCreate({required DocumentReference commentDocumentReference}) async {
    final comment =
        CommentModel.fromSnapshot(await commentDocumentReference.get());
    final post =
        PostModel.fromSnapshot(await comment.postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    // update comment
    // add category of the post, update `order` field.
    // TODO depth and order
    await commentDocumentReference.update({
      'category': post.category,
      'order': '',
      'depth': '',
    });

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // increase on of comments in category docuemnt, user doucment, post document

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
          'created_at': post.createdAt.toDate().toIso8601String(),
          'updated_at': post.updatedAt.toDate().toIso8601String(),
          'content': post.content,
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
