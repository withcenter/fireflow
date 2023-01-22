import 'package:fireflow/fireflow.dart';

class Config {
  static Config get instance => _instance ??= Config();
  static Config? _instance;

  /// [supa] returns true if supabase is enabled.
  bool get supa => supabase != null;
  SupabaseOptions? supabase;
}
