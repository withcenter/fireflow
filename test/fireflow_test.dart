import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  // });

  test('AppService::addOne', () {
    final fakeDb = FakeFirebaseFirestore();
    final appService = AppService.instance;
    expect(appService.runtimeType, AppService);
  });
}
