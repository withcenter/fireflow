# Supabase

- We support the supabase for the text search and the complicated conditional filterings.
  - User profile, post, are comment are automatically saved into supabase if the option is enabled.
  - Only the public data (non-sensitive private information of the user) should be saved in the supabase.

- See the offical document for understanding [the Supabase](https://docs.flutterflow.io/data-and-backend/supabase).

- To enable the Supabase in the fireflow,
  - Create tabls `users_public_data`, `posts`, `comments`, and `posts_and_comments` in Supabase.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-supabase.jpg?raw=true "Supabase")
  - set the `supabase` options like below.
    - `AppService.instance.init(supabase: SupabaseOptions(...))`.
    - See [the API reference](https://pub.dev/documentation/fireflow/latest/fireflow/SupabaseOptions-class.html) for details.

## Supabase settings

- Initialize supabase first, then put supabase options on AppService.

```dart
Supabase.initialize(
  url: 'https://crhqrbyjksnyqdrpqedr.supabase.co',
  anonKey:'eyJhbGc----xxxx---3bCoIh8is',
);
AppService.instance.init(supbase: SupabaseOptions( ... ));
```




## Supabase Table

### users_public_data

### posts

