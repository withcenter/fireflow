import 'package:fireflow/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseService get supabase => SupabaseService.instance;

class SupabaseService {
  static SupabaseService get instance => _instance ??= SupabaseService();
  static SupabaseService? _instance;

  SupabaseQueryBuilder get usersPublicData =>
      Supabase.instance.client.from(Config.instance.supabase!.usersPublicData!);
  SupabaseQueryBuilder get posts =>
      Supabase.instance.client.from(Config.instance.supabase!.posts!);
  SupabaseQueryBuilder get comments =>
      Supabase.instance.client.from(Config.instance.supabase!.comments!);

  bool get backupUsersPubicData =>
      Config.instance.supa && Config.instance.supabase!.usersPublicData != null;
  bool get backupPosts =>
      Config.instance.supa && Config.instance.supabase!.posts != null;
  bool get backupComments =>
      Config.instance.supa && Config.instance.supabase!.comments != null;
}
