import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';

Future loadUsers() async {
  dog('Load test users');
  TestConfig.a = await UserService.instance.getByEmail(TestConfig.emailA);
  TestConfig.b = await UserService.instance.getByEmail(TestConfig.emailB);
  TestConfig.c = await UserService.instance.getByEmail(TestConfig.emailC);
  TestConfig.d = await UserService.instance.getByEmail(TestConfig.emailD);
  TestConfig.admin =
      await UserService.instance.getByEmail(TestConfig.adminEmail);
}

Future clear() async {
  dog('Clear all posts of test users');
  await loginAsAdmin();
  wait(500);
  final snapshot =
      await PostService.instance.col.where('userDocumentReference', whereIn: [
    TestConfig.a.ref,
    TestConfig.b.ref,
    TestConfig.c.ref,
    TestConfig.d.ref,
    TestConfig.admin.ref,
  ]).get();

  dog('Got ${snapshot.size} posts to delete');

  for (final doc in snapshot.docs) {
    final post = PostModel.fromSnapshot(doc);
    dog('Deleting, title: ${post.title}');
    await doc.reference.delete();
  }
}

Future wait([int? ms]) async {
  await Future.delayed(Duration(milliseconds: ms ?? 200));
}

Future loginAsAdmin() async {
  return loginAs(TestConfig.adminEmail, TestConfig.adminPassword);
}

Future loginAs(String email, [String? password]) async {
  dog('Login as $email');
  await UserService.instance
      .loginOrRegister(email, password ?? TestConfig.password);
  await UserService.instance.publicRef.update({'email': email});
  dog('uid: ${UserService.instance.uid}');
}

Future loginA() => loginAs(TestConfig.emailA);
Future loginB() => loginAs(TestConfig.emailB);
Future loginC() => loginAs(TestConfig.emailC);
Future loginD() => loginAs(TestConfig.emailD);

Future createPost() async {
  dog('Create a post');
  final ref = await PostService.instance.col.add({
    'category': 'qna',
    'userDocumentReference': UserService.instance.ref,
    'title':
        'Created by ${UserService.instance.my.data['email']} at ${DateTime.now()}',
    'content':
        'Content. Created by ${UserService.instance.my.data['email']} at ${DateTime.now()}',
  });
  await PostService.instance.afterCreate(postDocumentReference: ref);
}

/// Deletes all the posts of the login user.
Future deletePosts() async {
  dog('Delete all posts');
  final snapshot = await PostService.instance.col
      .where('userDocumentReference', isEqualTo: UserService.instance.ref)
      .get();
  for (final doc in snapshot.docs) {
    await doc.reference.delete();
  }
}

/// Clear feeds of the login user.
Future clearFeeds() async {
  dog('Clear all feeds of ${UserService.instance.my.data['email']}}');
  await UserService.instance.publicRef.update({
    'lastPost': FieldValue.delete(),
    'recentPosts': FieldValue.delete(),
  });
}
