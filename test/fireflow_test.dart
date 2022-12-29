import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });

  test('AppService::addOne', () {
    final appService = AppService.instance;
    expect(appService.addOne(2), 3);
    expect(appService.addOne(-7), -6);
    expect(appService.addOne(0), 1);
  });
}
