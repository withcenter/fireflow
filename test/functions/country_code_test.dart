import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() {
  test('countryCode', () {
    expect(countryCode('82').length, 3);
    expect(countryCode('+82').first['dial_code'], '+82');
  });

  test('countryCode', () {
    expect(countryCode(null, favorites: ['+82', '+63']).first['dial_code'], '+82');
    expect(countryCode(null, favorites: ['+82', '+63']).first['isFavorite'], true);
    expect(countryCode(null, favorites: ['+82', '+63'])[1]['dial_code'], '+63');
    expect(countryCode(null, favorites: ['+82', '+63'])[2]['name'], 'Divider');
    expect(countryCode(null, favorites: ['+82', '+63'])[2]['isDivider'], true);
  });
}
