/// SupabaseOptions
///
/// [usersPublicData] is the name of the table that stores public user data. If
/// this is null, then the user public data is not stored in Supabase.
/// [posts] is the name of the table that stores posts. If this is null, then
/// the posts are not stored in Supabase.
/// [comments] is the name of the table that stores comments. If this is null,
/// then the comments are not stored in Supabase.
class SupabaseOptions {
  final String? usersPublicData;
  final String? posts;
  final String? comments;

  SupabaseOptions({
    this.usersPublicData,
    this.posts,
    this.comments,
  });
}
