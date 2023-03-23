import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';

/// SystemSettingModel is a class that represents a user's setting.
///
class SystemSettingService {
  static SystemSettingService get instance =>
      _instance ?? (_instance = SystemSettingService());
  static SystemSettingService? _instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  CollectionReference get col =>
      FirebaseFirestore.instance.collection('system_settings');
  DocumentReference doc(String id) =>
      FirebaseFirestore.instance.collection('system_settings').doc(id);
  DocumentReference get counters => doc('counters');

  User get my => FirebaseAuth.instance.currentUser!;

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
  Future<SystemSettingModel> get(String id) async {
    return SystemSettingModel.fromSnapshot(await doc(id).get());
  }

  /// increase noOfPosts by 1.
  ///
  /// This method is used when a new post is created.
  Future increaseNoOfPosts() =>
      counters.update({'noOfPosts': FieldValue.increment(1)});

  /// increase noOfComments by 1.
  ///
  /// This method is used when a new comment is created.
  Future increaseNoOfComments() =>
      counters.update({'noOfComments': FieldValue.increment(1)});
}
