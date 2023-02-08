/// SupabaseOptions
///
/// [usersPublicData] is the name of the table that stores public user data. If
/// this is null, then the user public data is not stored in Supabase.
///
/// [posts] is the name of the table that stores posts. If this is null, then
/// the posts are not stored in Supabase.
///
/// [comments] is the name of the table that stores comments. If this is null,
/// then the comments are not stored in Supabase.
///
/// [postsAndComments] is the name of the table that stores posts and comments.
/// If this is null, then the posts and comments are not stored in the
/// [postsAndComments] table of Supabase.
///
/// By storing posts and comments in the same table, it would be easy to do the
/// search. If you prefer to search for the posts and the comments separately,
/// you may set [postsAndComments] to null.
class SupabaseOptions {
  final String? usersPublicData;
  final String? posts;
  final String? comments;
  final String? postsAndComments;
  final String? search;

  SupabaseOptions({
    this.usersPublicData,
    this.posts,
    this.comments,
    this.postsAndComments,
    this.search,
  });
}
