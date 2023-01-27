import 'dart:developer';

import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';

class TestService {
  static final TestService instance = _instance ??= TestService();
  static TestService? _instance;
  TestService();

  Future run() async {
    await loginA();
    await createPost();
    await loginB();
    await follow(TestConfig.emailA);
    await feeds();
  }

  Future loginA() async {
    log('Login as A');
    await UserService.instance.loginOrRegister(TestConfig.emailA, TestConfig.password);
    await UserService.instance.publicRef.update({'email': TestConfig.emailA});
    log('uid: ${UserService.instance.uid}');
  }

  Future loginB() async {
    log('Login as B');
    await UserService.instance.loginOrRegister(TestConfig.emailB, TestConfig.password);
    await UserService.instance.publicRef.update({'email': TestConfig.emailB});
    log('uid: ${UserService.instance.uid}');
  }

  Future loginC() async {
    log('Login as C');
    await UserService.instance.loginOrRegister(TestConfig.emailC, TestConfig.password);
    await UserService.instance.publicRef.update({'email': TestConfig.emailC});
  }

  Future loginD() async {
    log('Login as D');
    await UserService.instance.loginOrRegister(TestConfig.emailD, TestConfig.password);
    await UserService.instance.publicRef.update({'email': TestConfig.emailD});
  }

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
