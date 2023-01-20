import 'package:fireflow/fireflow.dart';

class Config {
  static Config get instance => _instance ??= Config();
  static Config? _instance;

  SupabaseConfig supabase = SupabaseConfig();
}

class SupabaseConfig {
  late final SupabaseTables tables;
}
