import 'dart:developer';

import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';

class TestService {
  static final TestService instance = _instance ??= TestService();
  static TestService? _instance;
  TestService();

  Future run() async {
    await clear();
    await loadUsers();
    await loginA();
    await createPost();
    await loginB();
    await follow(TestConfig.emailA);
    await feeds();
  }

  /// Prepare test.
  ///
  /// Call this only one time if the test has been run before.
  Future prepare() async {
    log('Prepare test. Create test users.');
    await loginA();
    await wait();
    await loginB();
    await wait();
    await loginC();
    await wait();
    await loginD();
    await wait();
    await loginAsAdmin();
    await wait();
  }

  Future loadUsers() async {
    log('Load test users');
    TestConfig.a = await UserService.instance.getByEmail(TestConfig.emailA);
    TestConfig.b = await UserService.instance.getByEmail(TestConfig.emailB);
    TestConfig.c = await UserService.instance.getByEmail(TestConfig.emailC);
    TestConfig.d = await UserService.instance.getByEmail(TestConfig.emailD);
  }

  Future clear() async {
    log('Clear all posts of test users');
    loginAsAdmin();
    wait();
    final snapshot = await PostService.instance.col.where('userDocumentReference', arrayContainsAny: [
      TestConfig.a.ref,
      TestConfig.b.ref,
      TestConfig.c.ref,
      TestConfig.d.ref,
    ]).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future wait() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future loginAsAdmin() async {
    return loginAs(TestConfig.adminEmail, TestConfig.adminPassword);
  }

  Future loginAs(String email, [String? password]) async {
    log('Login as $email');
    await UserService.instance.loginOrRegister(email, password ?? TestConfig.password);
    await UserService.instance.publicRef.update({'email': email});
    log('uid: ${UserService.instance.uid}');
  }

  Future loginA() => loginAs(TestConfig.emailA);
  Future loginB() => loginAs(TestConfig.emailB);
  Future loginC() => loginAs(TestConfig.emailC);
  Future loginD() => loginAs(TestConfig.emailD);

  Future createPost() async {
    log('Create a post');
    final ref = await PostService.instance.col.add({
      'category': 'qna',
      'userDocumentReference': UserService.instance.ref,
      'title': 'Hello World',
      'content': 'This is a test post.',
    });
    await PostService.instance.afterCreate(postDocumentReference: ref);
  }

  Future follow(String email) async {
    log('Follow $email');
    final user = await UserService.instance.getByEmail(email);
    await UserService.instance.follow(user.ref);
  }

  Future feeds() async {
    log('Feeds');
  }
}
