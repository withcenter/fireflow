# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.



# AppService

## AppService Initialization


* To initialize the app service, you need to pass
  * proper (alive) build context for navigation. It will be used for navigating when the push message has been tapped.

```dart
final router = GoRouter( ... );
SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  AppService.instance.init(
    context: router.routerDelegate.navigatorKey.currentContext!,
    debug: true,
    supabase: true,
    tables: SupabaseTables(
      usersPublicData: 'users_public_data',
      posts: 'posts',
      comments: 'comments',
    ),
  );
});
```

# Post

## Post create


# Comment

## Comment create

- To create a comment, add a document under the comment collection in Firestore. Then call `afterCreate`.
- The `depth` field must be set to 1.

```dart
ElevatedButton(
    onPressed: () async {
    final ref = await CommentService.instance.col.add({
        'postDocumentReference': PostService.instance.doc(widget.postId),
        'userDocumentReference': UserService.instance.ref,
        'content': comment.text,
        'createdAt': FieldValue.serverTimestamp(),
        'order': commentOrder(null, null, post.noOfComments),
        'depth': 1,
    });
    await CommentService.instance.afterCreate(commentDocumentReference: ref);
    },
    child: const Text('Submit'),
),
```



# User

## MyDoc

