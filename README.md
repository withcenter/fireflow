![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

FlutterFlow Documents: [English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/ko/README.md)\
Flutter Documents: [English](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutter/en/README.md)

# Fireflow

* `Fireflow` is an open source, easy to use and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is developped for `FlutterFlow`. But it can be used for `Flutter` also.
  * For the example code of Flutter, see [the example project](https://github.com/withcenter/fireflow/tree/main/example).

* If you encounter an error, please create an issue in [fireflow git issue](https://github.com/withcenter/fireflow/issues).




## Table of Contents

- [About the FireFlow](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/about.md)
- [Getting Start](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/getting_start.md)
- [Structure of FireFlow](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/structure.md)
- [User](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/user.md)
- [User setting](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/user_setting.md)
- [System setting](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/system_setting.md)
- [Push Notifications](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/push.md)
- [Chat](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/chat.md)
- [Forum](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/forum.md)
- [Storage Files](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/file.md)
- [Report](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/report.md)
- [Bookmark](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/bookmark.md)
- [Supabase](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/supabase.md)
- [Text Translation](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/translation.md)
- [Actions](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/action.md)
- [Unit Testing](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/testing.md)
- [Development Tips](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/tip.md)
- [Known Issues](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/known-issue.md)
- [Trouble Shooting](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/trouble-shooting.md)




# TODO

- Make two fireflow
  - One for including all features - `fireflow`.
  - One for excluing `supabase` since `supabase` make a conflict on pubspec - `fireflow_light`.

- Chat welcome message for newly signed(registered) users.

- Hard limit on wait minutes for post creation.
  - Add a security rules for timestamp check.

- Display user online/offline status without Cloud function.
  - Record on/offline status on Realtime database only and create a widget to display whether the user is online or offline.
  - If the on/off status is not save in firestore, it cannot be searched. but it can display.

- How to display online/offline users by creating a function in GCP.

- Chat
  - Block the moderator to leave the chat room when there are other members in the room.
  - Destroying the chat room. The fireflow will automatically remove all users and delete the chat room.
  - Block users not to enter the chat room. `blockUsers` will hold the list of the blocked users.
  - Sending push notification to all users including those who are unsubscribed the chat room.

- Since the `AppCheck` is built-in by Flutterflow, why don't fireflow remove the security rules and `/users_public_data`?

- Image cropping before uploading.

- Sample application "Schedule management" app.
  - It can be a kind of todo app, calendar app, task app.
  - Works based on time line.
  - An event can be repeat.
  - With push notification. Scheduling push notification in advance will not work here. There must be a cron like scheduler which send push notificatoin by search the event date on every minute.

- Delete the post document itself if the post has no comments or all the comments has been deleted.
- Delete the comment document if it has no decendants or all the decendants are deleted.
