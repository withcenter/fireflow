import 'dart:math';

/// Get first string of a list
///
/// Returns the first string in the list, or an empty string if the list is empty.
/// Note, it returns null if the list is empty.
String? firstString(List<String> strings) {
  return strings.isEmpty ? null : strings.first;
}

String safeString(String? content) {
  if (content == null) {
    return '';
  }
  content = content.replaceAll(RegExp(r'<[^>]*>'), '');
  content = content.replaceAll('\r', '');
  content = content.replaceAll('\n', ' ');
  content = content.replaceAll('\t', ' ');
  content = content.substring(0, min(content.length, 64));
  return content;
}
