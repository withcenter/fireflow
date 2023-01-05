import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() {
  test('mimeType', () {
    expect(mimeType('/abc/def.jpeg'), 'image/jpeg');
    expect(mimeType('/abc/def.png'), 'image/png');
    expect(mimeType('/audio/file.mp3'), 'audio/mpeg');
    expect(mimeType('abc.txt'), 'text/plain');
    expect(mimeType('abc/def/.mp4'), 'video/mp4');
    expect(mimeType('jjj/oyoy/file.mp4.pdf'), 'application/pdf');
    expect(mimeType('.html'), 'text/html');
    expect(mimeType('exe'), null);
    expect(mimeType(''), null);
    expect(mimeType(null), null);
  });
  test('uploadUrlType', () {
    expect(uploadUrlType('/abc/def.jpeg'), 'image');
    expect(uploadUrlType('/abc/def.png'), 'image');
    expect(uploadUrlType('/audio/file.mp3'), 'audio');
    expect(uploadUrlType('abc.txt'), 'file');
    expect(uploadUrlType('abc/def/.mp4'), 'video');
    expect(uploadUrlType('jjj/oyoy/file.mp4.pdf'), 'file');
    expect(uploadUrlType('.html'), 'file');
    expect(uploadUrlType('exe'), 'file');
    expect(uploadUrlType(''), null);
    expect(uploadUrlType(null), null);
  });
}
