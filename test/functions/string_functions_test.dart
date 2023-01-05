import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() {
  test('firstString', () {
    expect(firstString(['strings', 'are', 'here']), 'strings');
    expect(firstString([]), null);
  });
}
