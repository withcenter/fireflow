# Forum

## Forum Schema



### recentPosts

- See [recentPosts](#feed-recentposts).

- Create the `recentPosts` Date Types like below.

Schema **recentPosts**
| Field Name    | Data Type |
| ------------- |----------:|
| postDocumentReference     | Doc Reference (psots) |
| createdAt     | Timestamp |
| title | String |
| content | String |
| photoUrl | String |


## Category

- Admin can create, update or delete the categories.
- Managing the categories is just as simple as creating, updating and deleting documents.
  - To create a category, add a document under `/categories` folder with `category` and `title` fields.
  - To update a category, just update it.
  - To delete a category, just delete it.





### Category Logic

- Fireflow creates its category document with the document id as the category itself. For instance, if the category is `qna`, the document path will be `/categories/qna`. The is because
  - it's easy to specify the category directly into the UI builder. For instance, you want to display the QnA forum, then you can pass `qna` as the category parameter. If you don't use the category as its document id, then the logic would get complicated to get the document id of `qna`.
  - it's easy to design the firestore security rules.


## Post


### Post Schema


Schema **posts**
| Field Name    | Data Type |
| ------------- |----------:|
| category     | String |
| postId | String |
| userDocumentReference     | Doc Reference (users) |
| createdAt | Timestamp |
| updatedAt | Timestamp |
| title | String |
| content | String |
| hasPhoto | Boolean |
| noOfComments | Integer |
| hasComment | Boolean |
| deleted | Boolean |
| likes | List < Doc Reference (users) > |
| noOfLikes | Integer |
| hasLike | Boolean |
| wasPremiumUser | Boolean |
| emphasizePremiumUser | Boolean |
| files | List < String > |

* Use `postId` to get the post document by `collection query`.



### Post Create
- `createdAt` must be set to `Firestore.serverTimestamp` when the post is created by Flutterflow.
- `updatedAt` is optional. And it is set by the fireflow.
- call `PostService.instance.afterCreate` after creating a post.


### Post Update

- call `PostService.instance.afterUpdate` after upating a post.


### Post Delete

- call `PostService.instance.afterDelete` after delete a post.
- Note that, when you develop app with fireflow, it is recommended not to actually delete the posts and comments even if the security rules allow to do so. It's up to you how you design the logic of your app. You may mark the app as deleted and may delete the title, comment, etc.


## Comment

### Comment Schema

Schema **comments**

| Field Name    | Data Type |
| ------------- |----------:|
| commentId | String |
| userDocumentReference     | Doc Reference (users) |
| postDocumentReference     | Doc Reference (posts) |
| parentCommentDocumentReference | Doc Reference (comments) |
| category | String |
| createdAt | Timestamp |
| content | String |
| files | List < String > |
| order | String |
| depth | Integer |
| likes | List < Doc Reference (users) > |
| noOfLikes | Integer |
| deleted | Boolean |

* Use `commentId` to get the comment document by `collection query`.



### Comment Create

- call `CommentService.instance.afterCreate` after creating a comment.


### Comment Update

- call `CommentService.instance.afterUpdate` after updating a comment.


### Comment Delete

- call `CommentService.instance.afterDelete` after deleting a comment.




### Logic of post creation

- When the user fill the form and submit, create a post document with
  - category (required)
  - userDocumentReference (optional, but recommended)
  - createdAt (optional, but recommend)
  - title (optional)
  - content (optional)
  - files (optional)

- After create, you need to call `PostService.instance.afterCreate()`. This will
  - fill up the remaining fields
  - increment post counters on multiple places
  - send push notifications
  - backup data into supabase (optiona)
  - do other tasks.





## Updating post

- `updatedAt` is optional. And it is set by the fireflow.



## Comment creation

- The `createdAt` field must be set to Firestore.serverTimestamp by flutterflow. `updatedAt` is optional.
- The `order` field must be set by Flutterflow. It's not an ideal for the fireflow to update the `order` field since fireflow is a bit slow. And the flutterflow needs it immediately after it creates a comment to display the comments in nested position.


## Last post

- `users_public_data.lastPost` has the last post that user created.

# Feeds, recentPosts

- Displaying the feed is very simple with fireflow. See [How to display feeds](#how-to-display-feeds).
- `/users_public_data/<uid> { recentPosts: ... }` has the user's recent posts and you can use this to display the feeds of the users who you follow.
- The `users_public_data.recentPosts` field is a map of `recentPosts` which has `postDocumentReference`, `title`, `content`, `createdAt`, and optional `photoUrl`. The `title` and `content` are in the safe string format. See the [safeString](#safe-string) function. If the post has no url, the `photoUrl` would not exists and this would lead an empty string when it is parsed by the model or by the flutterflow.
- You can set the number of recent posts to store the last recent posts of each user by passing a number in `AppService.instance.init()`. It's 20 by default. See the API reference for details.
```dart
AppService.instance.init(
  context: ...,
  noOfRecentPosts: 4,
  // ...
);
```

- The last post will be at first of the `recentPosts` array field.


## How to get feeds


- You can get feeds in two ways.

Example 1)

- Below gets the feeds using `Data Type` in FF. It helps with validation.

```dart
import 'package:fireflow/fireflow.dart';

Future<List<RecentPostsStruct>> feeds(int noOfFollowers) async {
  // Add your function code here!

  final feeds = await UserService.instance.feeds(noOfFollowers: noOfFollowers);

  return feeds
      .map((e) => createRecentPostsStruct(
          postDocumentReference: e.postDocumentReference,
          createdAt: e.createdAt.toDate(),
          title: e.title,
          content: e.content,
          photoUrl: e.photoUrl))
      .toList() as List<RecentPostsStruct>;
}
```

Example 2)

- Blow gets the feeds in JSON.

```dart
import 'package:fireflow/fireflow.dart';

Future<List<RecentPostsStruct>> feeds(int noOfFollowers) async {
  // Add your function code here!

  final feeds = await UserService.instance.jsonFeeds(noOfFollowers: noOfFollowers);

}
```


### Display the recent feed

- To display the last post of the users that the login-in user follows,
  - Get the followings order by `lastPostCreatedAt`.
  - Display the feed in `lastPost`.


### Display the list of recent feeds

- To display the recent feeds(posts) of the users that the login-in user follows,
  - Call `UserService.instance.jsonFeeds` to get the list of the feeds and display.

