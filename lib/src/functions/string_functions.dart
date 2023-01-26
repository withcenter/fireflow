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
