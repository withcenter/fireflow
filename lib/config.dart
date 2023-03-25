import 'package:fireflow/fireflow.dart';

class Config {
  Config._();
  static Config get instance => _instance ??= Config._();
  static Config? _instance;

  /// No of recent posts to store as feed in user's public data document.
  /// Recommendation is between 10 ~ 50.
  int noOfRecentPosts = 20;

  /// [supa] returns true if supabase is enabled.
  bool get supa => supabase != null;
  SupabaseOptions? supabase;
  MessagingOptions? messaging;

  /// [displayError] returns true if error should be displayed.
  bool displayError = false;

  /// Chat
  ///
  ///
  static int chatCountInterval = 60;

  /// [moveUserData] 에 지정된 컬렉션으로 요청한 사용자 필드를 이동한다.
  Map<String, dynamic>? moveUserData;
}
