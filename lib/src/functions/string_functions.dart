import 'dart:math';

/// Get first string of a list
///
/// Returns the first string in the list, or an empty string if the list is empty.
/// Note, it returns null if the list is empty.
String? firstString(List<String> strings) {
  return strings.isEmpty ? null : strings.first;
}

/// Safe string from a text.
///
/// In some cases the string should be in a moderate format. Like when the post
/// content is delivered over push notification, it should not be too long and
/// should not contain any special characters, nor HTML tags.
///
@Deprecated('Use safe in String Extension instead.')
String safeString(String? content) {
  if (content == null) {
    return '';
  }
  content = content.replaceAll(RegExp(r'<[^>]*>'), '');
  content = content.replaceAll('\r', '');
  content = content.replaceAll('\n', ' ');
  content = content.replaceAll('\t', ' ');
  content = content.substring(0, min(content.length, 128));
  return content;
}

/// Get a random string of a given length.
String randomString([int len = 32]) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      len,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}
