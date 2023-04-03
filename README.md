![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

FlutterFlow Documents: [English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/ko/README.md)\
Flutter Documents: [English](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutter/en/README.md)


**Breaking Changes**

* There are big breaking changes With the version of 0.1.x published in March. If you are using the version of 0.0.x, then keep using it that version. You may try the new version with new app.

# Fireflow

* `Fireflow` is an open source, easy to use and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is developped for `FlutterFlow`. But it can be used for `Flutter` also.
  * For the example code of Flutter, see [the example project](https://github.com/withcenter/fireflow/tree/main/example).

* If you encounter an error, please create an issue in [fireflow git issue](https://github.com/withcenter/fireflow/issues).


# How to start on Development

- Clone `git clone https://github.com/withcenter/fireflow`
- Run the example by
  - `cd fireflow/example`
  - `flutter run`

- You can continue building like this.


- If you want to build a real project, then
  - `cd apps` (or mkdir apps)
  - then, clone your app.
  - then, locate the fireflow in pubspec.yaml
  - then, start building.

- If you are working on FF, then better to use `ffloader`.








# Supabase

- Enable the Supabase from FlutterFlow or you will see an error like below

```dart
Because xxx_your_app_xxx depends on fireflow ^0.1.1 which depends on rxdart 0.27.5, rxdart 0.27.5 is required.
So, because xxx_your_app_xxx depends on rxdart 0.27.4, version solving failed.
```

- We use Supabase for Full Text Search. (Free version of Supabase will do)



# User

# Category

- How to use caetgory



# Forum

# Chat

# Report

# Translation




## Table of Contents

- [About the FireFlow](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/about.md)
- [Getting Start](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/getting_start.md)
- [Structure of FireFlow](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/structure.md)
- [User](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/user.md)
- [User setting](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/user_setting.md)
- [System setting](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/system_setting.md)
- [Push Notifications](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/push.md)
- [Chat](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/chat.md)
- [Forum](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/forum.md)
- [Storage Files](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/file.md)
- [Report](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/report.md)
- [Bookmark](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/bookmark.md)
- [Supabase](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/supabase.md)
- [Text Translation](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/translation.md)
- [Actions](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/action.md)
- [Unit Testing](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/testing.md)
- [Development Tips](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/tip.md)
- [Known Issues](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/known-issue.md)
- [Trouble Shooting](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/trouble-shooting.md)




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
