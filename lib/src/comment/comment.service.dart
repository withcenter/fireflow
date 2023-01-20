import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  static CommentService get instance => _instance ??= CommentService();
  static CommentService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('comments');
  DocumentReference doc(String category) => col.doc(category);

  afterCreate({required DocumentReference commentDocumentReference}) async {
    // update comment
    // add category of the post, update `order` field.

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // increase on of comments in category docuemnt, user doucment, post document

    // copy data into supabase.
  }
  afterUpdate({required DocumentReference commentDocumentReference}) async {
    // update comment
    // updatedAt...

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // copy data into supabase.
  }
}
