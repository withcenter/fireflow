# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.



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

