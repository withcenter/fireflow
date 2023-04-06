import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';

/// 테스트를 위해 사용자의 UID 를 미리 보관해 놓는다.
Future prepareUsers() async {
  if (TestConfig.admin != null) return;
  dog('Prepare test users -> Save UserModels to TestConfig');

  TestConfig.a = await UserService.instance
      .loginOrRegister(TestConfig.emailA, TestConfig.password);

  TestConfig.b = await UserService.instance
      .loginOrRegister(TestConfig.emailB, TestConfig.password);
  TestConfig.c = await UserService.instance
      .loginOrRegister(TestConfig.emailC, TestConfig.password);

  TestConfig.d = await UserService.instance
      .loginOrRegister(TestConfig.emailD, TestConfig.password);

  TestConfig.admin = await UserService.instance
      .loginOrRegister(TestConfig.adminEmail, TestConfig.password);
}

Future clear() async {
  dog('Delete all posts of test users');
  await loginAsAdmin();
  await wait(500);
  final snapshot =
      await PostService.instance.col.where('userDocumentReference', whereIn: [
    TestConfig.a.reference,
    TestConfig.b.reference,
    TestConfig.c.reference,
    TestConfig.d.reference,
    TestConfig.admin!.reference,
  ]).get();

  dog('clear() -> loginAsAdmin() -> Got ${snapshot.size} posts to delete');

  try {
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    dog('---------------> Failed to delete posts by admin. See if the uid of the admin is added into /system_settings/admin/ {${TestConfig.admin!.reference.id}: true } and the [admin] field of the user ${TestConfig.adminEmail} is set to true and has permission. -> Error: $e');
    rethrow;
  }
}

Future wait([int? ms]) async {
  await Future.delayed(Duration(milliseconds: ms ?? 200));
}

Future loginAsAdmin() async {
  return loginAs(TestConfig.adminEmail, TestConfig.password);
}

Future loginAs(String email, [String? password]) async {
  UserService.instance.logout();
  dog('Login as $email');
  await UserService.instance
      .loginOrRegister(email, password ?? TestConfig.password);
  await UserService.instance.update(email: email);
  dog('uid: ${UserService.instance.uid}');
}

Future loginA() => loginAs(TestConfig.emailA);
Future loginB() => loginAs(TestConfig.emailB);
Future loginC() => loginAs(TestConfig.emailC);
Future loginD() => loginAs(TestConfig.emailD);
Future loginI() => loginAs(TestConfig.emailI);

Future createPost({String? title}) async {
  dog('test.utils.dart -> createPost()');
  await PostService.instance.create(
    categoryId: 'qna',
    title: title ?? 'Created by ${my.displayName} at ${DateTime.now()}',
    content: 'Content. Created by ${my.displayName} at ${DateTime.now()}',
  );
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
