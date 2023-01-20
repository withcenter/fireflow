import 'package:fireflow/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseService get supabase => SupabaseService.instance;

class SupabaseService {
  static SupabaseService get instance => _instance ??= SupabaseService();
  static SupabaseService? _instance;

  SupabaseQueryBuilder get usersPublicData => Supabase.instance.client
      .from(Config.instance.supabase.tables.usersPublicData);
  SupabaseQueryBuilder get posts =>
      Supabase.instance.client.from(Config.instance.supabase.tables.posts);
  SupabaseQueryBuilder get comments =>
      Supabase.instance.client.from(Config.instance.supabase.tables.comments);
}
