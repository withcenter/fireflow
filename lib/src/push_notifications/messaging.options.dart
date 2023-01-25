/// MessagingOptions
///
/// If the MessgingOptions is set to null, then the FlutterFlow will not handle
/// foreground and background messages.
///
/// Set the [forground] to true if you want to handle foreground messages.
///
/// Set the [background] to true if you want to handle background messages. For
/// FlutterFlow, do not set it to true because the FlutterFlow
/// handles background messages by itself.
///
/// [onTapMessage] is a callback method and is called when the user taps on
/// foreground push notification snackbar. If this is set to null, then there
class MessagingOptions {
  final bool foreground;
  final bool background;
  final void Function(String initialPageName, Map<String, String> parameterData)
      onTap;

  MessagingOptions({
    this.foreground = false,
    this.background = false,
    required this.onTap,
  });
}
