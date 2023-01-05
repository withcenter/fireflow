import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() {
  test('mimeType', () {
    expect(mimeType('abc.txt'), 'text/plain');
    expect(mimeType('abc/def/.mp4'), 'video/mp4');
    expect(mimeType('jjj/oyoy/file.mp4.pdf'), 'application/pdf');
    expect(mimeType('.html'), 'text/html');
    expect(mimeType('exe'), null);
    expect(mimeType(''), null);
    expect(mimeType(null), null);
  });
}
