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



## Search

- Sometimes you would need to support full text search on a collection that is not supported by fireflow.
  - Let's you have a memo function in your app and you want the users search their memo.
  - You can use this `Search` functionality.


- First, define the search table in supabase like below.
  - You can name the table at your choice.


** search **
| Name | Type | Default Value | Primary |
|------|---------|---------------|---------|
| id   | varchar | NULL          | Yes     |
| created_at | timestamp | now() | No |
| category | varchar | NULL | No |
| text | text | NULL | No |


- Then, set the `search` property on supabase option on `AppService`.

```dart
AppService.instance.init(
  supabase: SupabaseOptions(
    search: 'search',
  ),
)
```


- Then, you will need to define custom actions to index the data.
  - There is only one field for text. You can combine tile and content or whatever into the text field.


