import 'package:fireflow/fireflow.dart';

class Config {
  static Config get instance => _instance ??= Config();
  static Config? _instance;

  /// No of recent posts to store as feed in user's public data document.
  /// Recommendation is between 10 ~ 50.
  late final int noOfRecentPosts;

  /// [supa] returns true if supabase is enabled.
  bool get supa => supabase != null;
  SupabaseOptions? supabase;
  MessagingOptions? messaging;

  /// [displayError] returns true if error should be displayed.
  bool displayError = false;
}
