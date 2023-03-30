# Known Issues

## Supabase and RxDart

- You need to enable supabase even if you are not using it because supabase depends on `rxdart ^0.27.5` and flutterflow depends on `rxdart ^0.27.4` and when supabase is enabled, flutterflow overrides the dependency to `rxdart ^0.27.4`.



## Push notification and back navigation

There is [an issue regarding the push notification](https://github.com/FlutterFlow/flutterflow-issues/issues/228). This bug produces an error on back navigation when the app is opened by tapping on the push message.


## [cloud_firestore/permission_denied] The caller does not have permission to execute the specified operation.

Most of the time, it really causes problems. But in a few cases, it is designed to produce permission errors while it is working fine.

For instance, in the `ChatRoomMessageList` widget of fireflow,

The chat room for 1:1 chat will be created in `initState` asynchronously while the app queries to read the messages in the ListView widget.

The app will first read the chat messages before the chat room exists. But to read chat messages, the chat room must exist. This is why there is a permission error.
The permission error may appear in the console, but still it works fine.
This permission error may not appear always.


[cloud_firestore/permission_denied] happens often when the app is listening to some documents and suddenly user login status changes. For instance, the app is listening to a chat room and the user suddenly leaves the chat room. And it would be best if the app handles all the [cloud_firestore/permission_denied] exceptions nicely, but in some cases (or in many cases) it is just okay with the permission exceptions.


## Snackbar


The issue below happens only when you zoom in the browser while running debug run.

![Flutterflow Firestore Deploy](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-snackbar-issue.jpg?raw=true)

