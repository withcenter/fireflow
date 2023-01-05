/// Get first string of a list
///
/// Returns the first string in the list, or an empty string if the list is empty.
/// Note, it returns null if the list is empty.
String? firstString(List<String> strings) {
  return strings.isEmpty ? null : strings.first;
}
