
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

FlutterFlow Documents: [English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/ko/README.md)\
Flutter Documents: [English](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutter/en/README.md)

# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is developped for `FlutterFlow`. But it can be used for `Flutter` also.
  * For the example code of Flutter, see [the example project](https://github.com/withcenter/fireflow/tree/main/example).

* If you encounter an error, please create an issue in [fireflow git issue](https://github.com/withcenter/fireflow/issues).

- [Fireflow](#fireflow)
- [Overview](#overview)
- [Features](#features)
- [TODO](#todo)
- [Getting started](#getting-started)
  - [Setting up Firebase](#setting-up-firebase)
    - [Firestore Security Rules](#firestore-security-rules)
  - [Enable deeplink](#enable-deeplink)
  - [Enable Push notifications](#enable-push-notifications)
  - [AppService](#appservice)
  - [Local State Variable](#local-state-variable)
  - [Keys](#keys)
    - [Open AI Keys](#open-ai-keys)
- [The structure of Fireflow](#the-structure-of-fireflow)
  - [Files and folders](#files-and-folders)
- [User](#user)
  - [users schema](#users-schema)
  - [users\_public\_data schema](#users_public_data-schema)
  - [Register and sign-in](#register-and-sign-in)
  - [How to get users\_public\_data document](#how-to-get-users_public_data-document)
  - [Profile photo upload](#profile-photo-upload)
  - [Adding extra fields on users\_public\_data schema](#adding-extra-fields-on-users_public_data-schema)
  - [User coding guideline](#user-coding-guideline)
- [User setting](#user-setting)
  - [New Comment Notification](#new-comment-notification)
  - [Forum Category Subscription](#forum-category-subscription)
- [System setting](#system-setting)
  - [Admin](#admin)
  - [Counters](#counters)
- [Push notification](#push-notification)
  - [Push notification data](#push-notification-data)
    - [Push notification data of post and comment](#push-notification-data-of-post-and-comment)
    - [Push notification data of chat](#push-notification-data-of-chat)
  - [Foreground Push Notification and Routing](#foreground-push-notification-and-routing)
  - [MessageModel](#messagemodel)
- [Chat](#chat)
  - [Chat Overview](#chat-overview)
  - [Chat schema](#chat-schema)
    - [Chat Room collection](#chat-room-collection)
    - [Chat message collection](#chat-message-collection)
  - [Logic of chat](#logic-of-chat)
    - [Entering Chat Room to begin chat](#entering-chat-room-to-begin-chat)
    - [How to list my chat rooms](#how-to-list-my-chat-rooms)
    - [How to display menu when the chat message has tapped.](#how-to-display-menu-when-the-chat-message-has-tapped)
    - [How to leave a group chat room.](#how-to-leave-a-group-chat-room)
    - [How to display an uploaded file.](#how-to-display-an-uploaded-file)
    - [How to not invite the same user.](#how-to-not-invite-the-same-user)
    - [How to display the protocol message.](#how-to-display-the-protocol-message)
    - [How to remove a user](#how-to-remove-a-user)
    - [How to receive and display the push notifications while the app is foreground.](#how-to-receive-and-display-the-push-notifications-while-the-app-is-foreground)
    - [How to display the number of chat rooms with new messages.](#how-to-display-the-number-of-chat-rooms-with-new-messages)
    - [How to query to the Open AI - GPT.](#how-to-query-to-the-open-ai---gpt)
    - [How to change chat room title](#how-to-change-chat-room-title)
    - [How to send chat message](#how-to-send-chat-message)
    - [How to create a group chat](#how-to-create-a-group-chat)
  - [Chat Design](#chat-design)
    - [ChatRoomProtocolMessage](#chatroomprotocolmessage)
- [Forum](#forum)
  - [Forum Schema](#forum-schema)
    - [recentPosts](#recentposts)
  - [Category](#category)
    - [Category Logic](#category-logic)
  - [Post](#post)
    - [Post Create](#post-create)
    - [Post Update](#post-update)
    - [Post Delete](#post-delete)
  - [Comment](#comment)
    - [Comment Create](#comment-create)
    - [Comment Update](#comment-update)
    - [Comment Delete](#comment-delete)
    - [Logic of post creation](#logic-of-post-creation)
  - [Updating post](#updating-post)
  - [Comment creation](#comment-creation)
  - [Last post](#last-post)
- [Feeds, recentPosts](#feeds-recentposts)
  - [How to display feeds](#how-to-display-feeds)
    - [Display the recent feed](#display-the-recent-feed)
    - [Display the list of recent feeds](#display-the-list-of-recent-feeds)
- [Files](#files)
  - [Storage Files Schema](#storage-files-schema)
  - [Overview of file management](#overview-of-file-management)
  - [Logic of File management](#logic-of-file-management)
    - [Triggering UpdateStorageFiles](#triggering-updatestoragefiles)
  - [Customizing File Management](#customizing-file-management)
    - [Simple File Listing](#simple-file-listing)
    - [File Listing with Filters and Order](#file-listing-with-filters-and-order)
- [Supabase](#supabase)
  - [Supabase settings](#supabase-settings)
  - [Supabase Table](#supabase-table)
    - [users\_public\_data](#users_public_data)
    - [posts](#posts)
- [Text translation support](#text-translation-support)
  - [Putting translations directly into the Firestore](#putting-translations-directly-into-the-firestore)
  - [Translate widget](#translate-widget)
  - [List of translations](#list-of-translations)
- [Widgets](#widgets)
  - [Custom Popup widget.](#custom-popup-widget)
    - [Custom Popup Tips](#custom-popup-tips)
    - [How to implement the custom ppup](#how-to-implement-the-custom-ppup)
    - [Custom poup step by step example](#custom-poup-step-by-step-example)
      - [Create a child Component](#create-a-child-component)
      - [Create a popup Component](#create-a-popup-component)
      - [Custom widget for Custom Popup](#custom-widget-for-custom-popup)
      - [Add the custom widget in your design](#add-the-custom-widget-in-your-design)
  - [DisplayMedia widget](#displaymedia-widget)
  - [SafeArea widget](#safearea-widget)
- [Actions](#actions)
  - [snackBarSuccess](#snackbarsuccess)
  - [snackBarWarning](#snackbarwarning)
- [Functions](#functions)
  - [Country Code](#country-code)
- [Testing](#testing)
  - [Fireflow real test](#fireflow-real-test)
- [Developer coding guide](#developer-coding-guide)
  - [Developing with Fireflow](#developing-with-fireflow)
  - [Development tips](#development-tips)
    - [Safe string](#safe-string)
- [Sponsors](#sponsors)
- [Known Issues](#known-issues)
  - [Push notification and back navigation](#push-notification-and-back-navigation)
  - [\[cloud\_firestore/permission\_denied\] The caller does not have permission to execute the specified operation.](#cloud_firestorepermission_denied-the-caller-does-not-have-permission-to-execute-the-specified-operation)
  - [Snackbar](#snackbar)


# Overview

Flutterflow is a gorgeous platform to build mobile apps rapidly. The developers can build whatever apps they like without any limitations.

Flutterflow comes easy when the project is relatively small. But when the project grows with complicated functionalities and logics, you will feel the pressure of what the professional developer feels.

To make the apps fully functional, the developers definitely need the use of custom code. It's important, but many of Flutterflow developers are stuck with Custom functions, custom widgets, and custom actions.  That's where **Fireflow** came in.

Fireflow encapsulates all the complicated logics and serve most of the common use cases. Use it build professional apps like chat apps, SNS apps, community apps, and more.

# Features

- Enhanced user management
  - The documents of the `/users` collection have private information and shouldn't be disclosed. But the user information is needed to be disclosed for the most app features. To make it happen, I created another collection named `/users_public_data` that does not hold user's prviate information.

- File upload and display.
  - Any kinds of files can be uploaded and displayed like Image, Video, TXT, PDF, ZIP, etc.
  - It can be used in Chat, Forum and for any features.

- Chat
  - Custom design.
    - Tap on chat message to delete, edit, copy, open, etc.
  - Push notification. User can subscribe/unsubscribe chat room.
  - Display the number of chat room that has unread messages.
  - Open AI. GPT query. Chat members can query to GPT and share.
  - Uploading any kinds of files like Image, Video, TXT, PDF, ZIP, etc.
  - User invite and leave in Group chat.
  - Moderators can remove a user.
  - Moderators can't leave the chat room. But he can break the room. All users are no longer to use the chat room after admin breaks the room.
  - Moderators can block user.
  - Moderators can send push notification to all users even if some of them disabled the subscription.


- Forum
  - Complete functionalities of forum including
    - uploading multiple files.
    - displaying nested comments.
    - etc.
  - Forum is the based of all functions. You can create whatever features extending the forum.

- Push Notification
  - Sending push notification to all users.
  - Display the push notification while the app is on foreground.
  - Subscribe new comments under my posts and comments.
  - Subscribe new posts of a category.
  - Subscribe new comments of a category.

- Admin features
  - User management
  - Forum category management
  - Post & comment management
  - Uploaded file management


- Muti language support

- Enhanced Firestore Security Rules

- Custom widgets

# TODO

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


- Doc. not to follow himself.

# Getting started

To get started, you would need to install the necessary parts of the Fireflow.

## Setting up Firebase

### Firestore Security Rules

Fireflow has its own Firestore Security Rules to protect the app safer.

You may think `App check` will do for the security. Partly, yes. While `App Check` adds an important layer of protection against some (not all) abuse towards your backend, it does not replace Firebase's server-side security rules. See [the App Check offical document](https://firebase.google.com/docs/app-check#how_strong_is_the_security_provided_by).

To apply it, you will need to check the `Exclude` buttons on the Collections like below. 

![Flutterflow Firestore Deploy](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-firestore-deploy-1.jpg?raw=true)

And copy the [fireflow security rules](https://raw.githubusercontent.com/withcenter/fireflow/main/firebase/firestore.rules) and paste it into your Firebase firestore security rules.

![Firestore Security Rules](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/firestore-rules.gif?raw=true)

## Enable deeplink

- Enable the Deeplink in FlutterFlow.

## Enable Push notifications

- The fireflow is tightly coupled with the Push Notification as of now. So, you need to enable push notification on Flutterflow.

## AppService

- `AppService` will serve with the core services of fireflow through the lifecyle of the app. You can initialize like below.

```dart
import '../../backend/push_notifications/push_notifications_handler.dart';
import 'package:fireflow/fireflow.dart';

Future appService(BuildContext context) async {
  AppService.instance.init(
    context: context,
    debug: true,
    supabase: SupabaseOptions(
      usersPublicData: 'users_public_data',
      posts: 'posts',
      comments: 'comments',
    ),
    messaging: MessagingOptions(
      foreground: true,
      background: false,
      onTap: (String initialPageName, Map<String, String> parameterData) {
        dog('on message tap: $initialPageName, Map<String, String> $parameterData');
        context.pushNamed(initialPageName, queryParams: parameterData);
      },
    ),
  );
}
```

To see the details, refer the document of [AppService.init](https://pub.dev/documentation/fireflow/latest/fireflow/AppService/init.html)

As you can see, it uses the `push_notifications_handler.dart` that is generated by Fluterflow. So, you need to check `Exclude from compilation`.

The `onTapMessage` is the push notification handler while the app is foreground. And If you don't want it, you can remove that part including `import .../push_notifications_handler.dart;` And uncheck the `Exclude from compilation`.

- There are some functions, widgets and actions that don't need to connect to Firebase and don't need to use BuildContext. They are called as **Independent Components**.
  - For `Independent Components`, you don't have to initialize the `AppService`.
  - I should have decoupled the Independent Components, but I didn't for hoping that people who need the `Independent Components` would get interested in fireflow.


- Add the `appService` action on the root level screens.
  - One thing to note is that, the context that is given to `AppService` must be valid context. You may initialize the `AppService` on all the root level screens to provide valid context.
  - The root level screen is the screens that are the at bottom parts of the nav stack and the context of the screens must alive.
    - For instance, If the Home screen is always exists at the bottom of the nav stack, then you can only add the `appService` action on Home screen.
  - If you really don't know what to do, you can simply add the action on every page.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-on-page-load-app-service.jpg?raw=true "Adding App Service")



- If `debug` is set to true, then it prints the debug message to console.
- If `displayError` is set to true, then it display error messages as snackbar.



## Local State Variable

Note that, these local state variables may be changed based on your app logic.
 

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-local-states-2.jpg?v=2&raw=true "Local State Variables")

- `defaultImagePath` is the image path that will be used by default. For instance, when you add a Image widget and sometimes it needs the default image.
- `anonymousMaleUrl` is the male picture url that will be shown by default when the user is male and has no profile photo.
- `anonymousFemaleUrl` is the female picture url that will be used when the user is female and has no profile photo.
- `chatSendMessageAskResult` is the state that will hold the result of chat send option. When the user sends a message, he can choose an option whether to query to GPT or not.
- `gptLoader` is the state that when the user query to GPT, it will show the loading indicator.
- `anonymousEmail` is used for guest login.
- `anonymousPassword` is used for guest password. It's okay that the guest password is revealed to the public. Anonyone can login anyway.
- `isGuest` is needed to be set to true on home screen if the user signed in as guest.
- `tempStringArray` is for temporarily saving a string array. For instance, when a user uploads multiple files/photos, the app can save those urls into this temporary string array.
- `setState` is for updating the state.





## Keys

- Some keys like the `Open AI` key can't be exposed to public. Once it did, it will be automatically invalid. So, you need to keep it secret. In this manner, Fireflow keeps the keys in Firestore database.


### Open AI Keys

- Save the Open AI Keys at `/system_settings/keys {openAiApiKey: ... }`.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/firestore-keys.jpg?raw=true "Open AI API Keys")



# The structure of Fireflow

The fireflow reuses the code of the flutterflow since fireflow depends on flutterflow. But fireflow is decoupled from flutterflow. This means you can use fireflow with flutter.

## Files and folders

- `lib/src/actions`
  This folder contains codes that works like functions but depending on Firebase or Material design.

- `lib/src/functions`
  This folder contains codes that are independent from Firebase, nor Material design.

- `lib/src/widgets`
  This folder contains widgets.



# User

## users schema


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-users-schema.jpg?raw=true "Flutterflow users schema")


- Add `userPublicDataDocumentReference` to `users` schema. This is the connection to `users_public_data` schema.

- Add `admin` boolean. If this is set to true, the user will see admin menu. To give the user admin permission, you need to add the uid of the user into the system_settings collection.


## users_public_data schema

- Since `users` collection has private information like email and phone number, fireflow saves public information into `users_public_data` collection.
  - Even if the app adopts `App Check`, it needs more to secure the data. Since firestore always delivers the whole document to the client, it is vulnerable if you don't keep the private information in seperate document. The abusers can look at the data in the app or browser transfered over the network.

- Create the `users_public_data` schema in Flutterflow like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-users_public_data-schema.jpg?raw=true "Flutterflow users_public_data schema")


- `uid` is the the uid of the user.
- `userDocumentReference` is the document reference of the user.
- `displayName` is the display name of the user.
- `photoUrl` is the primary profile photo url of the user.
- `registeredAt` is the time that this document was created.
- `updatedAt` is the time that this document was updated.
- `gender` can be one of `M` or `F`. M as Male or F as Female
- `birthday` is the birthday of the user
- `followers` is the list of user document references who follow me(the login user).
  Meaning, the login user can add other user reference into the `followers` field in his document. Others don't have permission to update the `followers` field in other user's document.
- `hasPhoto` is set to `true` if the user has the primary profile photo. Or false.
- `isProfileComplete` is set to `true` if the user filled in the necessary fields in his profile. Or false.
- `coverPhotoUrl` is the url of the cover photo of the user.
- `recentPosts` is the list of the last recent posts that the user created. Note that, to create the `recentPosts` field in `posts` collection, you will need to create the `recentPosts` Data Type first.
- `lastPostCreatedAt` is the time that the user created the last post.
- `isPremiumUser` is set to `true` if the user is paid for premium service.

## Register and sign-in

- As long as the user signs in with Firebase Auth `sign-in logic` applies the same.

- When a user signs in, Fireflow will create
  - `/users_public_data/<uid>` document if it does not exists.
  - `/settings/<uid>` document if it does not exsits.

- When a user signs in for the first time, fireflow will send a welcome chat message to user.


## How to get users_public_data document


- When you need to get the public data document of a user, filter the `userDocumentReference` in the `users_public_data` schema with the `userPublicDataDocumentReference` of `Authenticated User`.

Note, that the `userPublicDataDocumentReference` in `users` collection is set on the very first time the app runs by `AppService`. So, it may be a good idea to not use it on the first screen of the app. You may use it on the second page and after.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-get-user-pub-doc.jpg?raw=true "How to get user public data document")


## Profile photo upload

- Uploading the profile photo of the user is much complicated than you may think.
  - If a user cancels on the following(immediate) upload after the user has just uploaded a profile photo, the app maintains the same URL on the widget state. So, it should simply ignore when the user canceled the upload.
  - The existing profile photo should be deleted (or continue to work) even if the actual file does not exist. There might be some cases where the photo fields have urls but the photos are not actually exists and this would cause a problem.


- When the user uploads his profile photo, use the `Upload Media Action` in fireflow (not in flutterflow), then pass the uploaded URL to `afterProfilePhotoUpload`. And leave all the other works to fireflow.

- For cover photo upload, update the photo using `Upload Media Action` in fireflow and url to `afterCoverPhotoUpload` action.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-photo.jpg?raw=true "User photo")


## Adding extra fields on users_public_data schema

- You can simply add more fields on users_public_data schema.


## User coding guideline

- `UserService.instance.loginOrRegister()` creates an account or logs in if the account is already exists. You can use it for user sign-in. Or guest sign-in. You may create an account in FirebaseAuth and let all the guest users to sign-in with that account.


- `UserService.instance.feeds()` returns the feeds of the users who the log-in user follows.

- There are many methods you may want to use as a custom action.


# User setting

- User settigns are kept in `/user_settings/<uid>` document.
  - It could be saved in `/users_public_data/<uid>` collection. But the problem is when the client lists/searches user information based on the settings, the firestore downloads the whole document whether is it big or small. And this leads the waste of network bandwidth, time consuming and lagging on the app. And even worse it costs more.

- You just set the settings. That's it. It will work.


## New Comment Notification

- If a user enable this option, the user will get push notification on every new comments under his posts or comments.
- To enable it, simple set `notifyNewComments` to true. Example) `/user_settings/<uid> {notifyNewComments: true}`.
- To disable it, set it to false or delete the field.


## Forum Category Subscription

- There are two types of push notification subscriptions. One is the post subscription, the other is the comment subscription.
- If a user subscribes for the post, then he will get a push notification whenever there is a new post under the category.
- If a user subscribes for the comment, he will get a push notification on very new comments under the category.
- To enable the post subscription, add the category reference into `postSubscriptions` array. Example) `/user_settings/<uid> {postSubscriptions: ['category/qnaCategoryReference']}`.
- To enable the comment subscription, add the category reference into `commentSubscriptions` array. Example) `/user_settings/<uid> {commentSubscriptions: ['category/qna']}`.




# System setting

Some API Keys like Open AI will be invalid once it is open to the public. So, it needs to be kept in the database (or somewhere else).

In Fireflow, those keys should be in /system_settings/keys { keyName: … }



## Admin


To set a user as an admin, You need to update the Firestore directly. You can do so within FF settings, or Firestore.

You need to add your UID (Or any other user’s UID that you want to set as an admin)
at /system_settings/admins { <USER_UID>: true }

You need to add {admin: true} in the `/users/{uid} {admin: true}` document. It's `/users` collection. Not the `/users_public_data` collection.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/set-admin.gif?raw=true "How to set admin")



## Counters

- `/settings/counters` has the number posts and comments.
  - `noOfPosts` has the number of posts.
  - `noOfComments` has the number of comments.




# Push notification

There are some differences from the notification logic of FF.

- The push notification sender's user reference is added to the parameter.
- The sender’s user document reference is always removed. Meaning, the sender will not receive the push notification he sent.
- Foreground push notification works.


## Push notification data


### Push notification data of post and comment

- To make the flutter push notification work with the flutterflow, it passes the data in a certain compatible format.
  - For post and comment,
    - the `initialPageName` is fixed to `PostView`
    - the parameter of the `PostView` is fixed to `postDocumentReferece` and is set to the post reference.
  
  This means, the page name of the post view must be `PostView` and the parameter of the `PostView` page must be `postDocumentReference`.
  Or when the user taps on the message, the app would not open the proper post view screen.


### Push notification data of chat

- To make the fireflow push notification work with the flutterflow, it passes the data in a certain compatible format.
  - the `intialPageName` is fixed to `ChatRoom`. So, the chat room must have `ChatRoom` as its page name.
  - the `parameterData` has `chatRoomId` and one of `chatRoomDocument` or `otherUserPublicDataDocument`. So, the `ChatRoom` must have parameters of `ChatRoomId`, `chatRoomDocument` and `otherUserPublicDataDocument`.
    - `chatRoomId` is a String, and have the chat room id.
    - the `chatRoomDocument` is set, if it's group chat. It's a string of chat room document path.
    - or the `otherUserPublicDataDocument` is set if it is one and one chat. It's a string of user public document path.
    Note that, the chat room requires the `chatRoomDocument` or the `otherUserPublicDataDocument` as a document. (Well, you may design differently.) And the fireflow will automatically convert the path of the document to a document when the page is opened when the user taps on the message. And the document itself cannot be delivered as push notification data.

## Foreground Push Notification and Routing

It is not ideal to do routings inside fireflow.
You can handle the tap event on push notification by adding `onTapMessage` callback to AppService.


## MessageModel

The `MessageModel` will handle all kinds of push notification data including, but not limited to chat, post, profile.




# Chat

## Chat Overview

- There are two types of chat room.
  - One is the one to one chat
  - The other is the group chat.

## Chat schema

- Chat service needs two collections.

### Chat Room collection


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-chat-rooms.jpg?raw=true "Chat rooms collection")

- `userDocumentReferences` is the participants document reference of the chat room.
- `lastMessage` is the last chat message.
- `lastMessageSentAt` is the timestamp of last message
- `lastMessageSeenBy` is the list of user reference who have read the message
- `lastMessageSentBy` is the user reference of the last chat message sender.
- `title` is the chat room title. The moderator can change it.
- `moderatorUserDocumentReferences` is the user document references of the moderators. The first user who created the chat room becomes a moderator automatically. And he can add more moderators.
- `unsubscribedUserDocumentReferences` is the document references of the users who disabled the notification of a new message for the chat room.
- `isGroupChat` is set to `true` if it's a group chat. Otherwise, false.
- `isOpenChat` is set to `true` if the chat room is open to anyone. When it is set to true, users can join the chat room.






### Chat message collection

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat_room_messages.jpg?raw=true "Chat rooms collection")

- `userDocumentReference` is the document reference of the user who sent this message.
- `chatRoomDocumentReference` is the reference of the chat room document.
- `text` is the chat message.
- `uploadUrl` is the url of the uploaded file. It can be an Image Path, Video Path, Audio Path or any upload url.
- `uploadUrlType` is the type of the upload file. It can be one of the following;
  - Empty string if there is no upload.
  - image
  - video
  - audio
  - file ( if the upload file is not one of image, video, audio, then it is file type ).
- `protocol` is the protocol states the purpose(or action) of the message. For instance, when a user invites another user, then the protocol is set to `invite`. It could be one of;
  - invite
  - remove
  - leave
  When the protocol is set, there might be extra information.
- `protocolTargetUserDocumentReference` is the target user document reference who is being affected by the protocol. For instance, User A invites user B. then, the protocol is set to `invite`. And A's ref goes into userDocumentReference and B's ref goes into protocolTargetUserDocumentReference.
- `sentAt` is the time that the message was sent.



## Logic of chat


### Entering Chat Room to begin chat

- For A, to chat with B
  - A enters the `ChatRoom` screen with the parameter of the `userPublicDataDocument` of B over
  - Then, in the `ChatRoom` Screen,
  - Display user’s photo and name on the app bar from `userPublicDataDocument`
  - Use the `ChatRoomMessages` custom widget with the reference of `userPublicDataDocument`.
  - Note that, If a user document reference is given to fireflow ChatRoomMessages widget, it is considered as 1:1 chat.


- To begin a group chat,
  - A opens a group chat with `chatRoomDocument`.
  - Display chat room information from `chatRoomDocument`.
  - In the chat room, it uses the `ChatRoomMessages` custom widget with the reference of `chatRoomDocument`.
  - If a chat room document reference is given to fireflow ChatRoomMessages widget, it is considered as group chat.




### How to list my chat rooms

* Get the chat rooms that have the logged in user’s document reference in the `userDocumentReferences` field.

* To get the list of chat rooms from the Firestore
  * Add ListView (or Column)
  * Add Backend Query
    * Choose `chat_rooms` on Collection.
    * Query Type to `List of Documents`
    * Add a Filter
      * Collection Field Name to `userDocumentReferences`
      * Relation to `Array Contains`
      * Value Source to `User Record Reference`
    * Add an ordering
      * Collection Field Name to `lastMesageSentAt`
      * Order to `Decreasing`


* To display the chat rooms
  * Add a `Column` as the child of `List View`.
  * Add `Two Containers` to the `Column`. The first Container is for displaying the one to one chat and the second Container is for displaying the group chat.
  
  * (One to One chat Container)
    * Add Backend Query
      * `Query Collection`.
      * Query Type to `Single Document`.
      * Add a Filter.
      * Collection Field Name to `userDocumentReference`.
      * Relation to `Equal To`.
      * Value Source to Custom Function named `chatOtherUserReference` and set its two parameters.
        * userDocumentReferences to `chat_rooms userDocumentReferences`.
        * myUserDocumentReference to `logged in user's reference`.
    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-backend.png?raw=true "Chat rooms collection")
    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-backend-2.png?raw=true "Chat rooms collection")
        
    * Add conditional visibility as the Num List Items of `monderatorUserDocumentReferences` is equal to 0.

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-sing-chat.jpg?raw=true "Chat rooms collection")

    * Inside the `Container` add `Row`
    * Inside the `Row` add `Container`
    * Inside the `Container` add `Row` again

    Inside the `Row` you can now add a widget to display the `user's photo` and text widgets to display the `user's name`, `last message` and `the time` it was sent

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-row.png?raw=true "Chat rooms collection")

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-row-2.png?raw=true "Chat rooms collection")

    * To display the user's photo:
      * Add `Image Widget` or `Custom Widget`
      * Set its path to `if else condition` (we need to check first if the user's photo is set or not)

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-onetoone-chat-2.png?raw=true "Chat rooms collection")
            
        * (if condition) check if the user's photo url is set, if it is, then set it as the path of the image widget
        * (else condition) another if else condition to check if the user's gender is `male or female` to correctly show the placeholder image based on the user's gender
          * (if condition) check if the user is female, if it is, then set the path of the image widget to the female placeholder image url stored in local state
          * (else condition) if the user is not female, set the path of the image widget to the male placeholder image url stored in local state

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-sing-chat-user-photo-condition-2.png?raw=true "Chat rooms collection")
        

    * To display the user's name and the last message sent:
      * Add `Column`
      * Inside the `Column` add two text widgets

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-user-name-last-mesage.png?raw=true "Chat rooms collection")

        * (top text widget) set its value to user's display name

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-user-display-name.png?raw=true "Chat rooms collection")
                
        * (bottom text widget) set its value to chat_rooms last message

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage.png?raw=true "Chat rooms collection")

    * To display the chat_rooms last message timestamp
      * Add `Column`
      * Inside the `Column` add text widget
      * Set text widget's value to chat_rooms `lastMessageSentAt` timestamp with a format of `M/d h:mm a`

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage-timestamp.png?raw=true "Chat rooms collection")

      * Add conditional visibility to check if the lastMessageSent is set

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-sing-chat-last-message-timestamp-visibility.png?raw=true "Chat rooms collection")

            


  * (group chat container)
    * Add conditional visibility as the `Num List Items` of `monderatorUserDocumentReferences` is greater than 0.

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-group-chat.jpg?raw=true "Chat rooms collection")

    * Inside the `Container` add `Row`

    * Inside the `Row` add `Container`

    * Inside the `Container` add `Row` again

    * Inside the `Row` you can now add a widget to display the users' photos and text widgets to display group chat's last message and the time it was sent

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-grouchat-row.png?raw=true "Chat rooms collection")

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-grouchat-row-2.png?raw=true "Chat rooms collection")

    * To display the group chat's two users' photos:
      * Add `Stack` to the `Row`
      * Inside the `Stack` add two image widget or custom widget to display the group chat's two users' photos (the first photo will display the last message sender photo and the second photo will display the last person who entered the chat room)

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-stack-group-chat-two-users-photos.png?raw=true "Chat rooms collection")

      * To display the last message sender photo:
        * Add `Backend Query`
        * `Query Collection`
        * Collection Field to `users_public_data`
        * Query Type to `Single Document`
        * Add a filter
          * Collection Field Name to `userDocumentReference`
          * Relation to `Equal To`
          * Vaue Source to `lastMessageSentBy`

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-group-chat-last-message-user-photo.png?raw=true "Chat rooms collection")

        * Add conditional visibility by checking if the `lastMessageSentBy` field is set.

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-user-photo-conditional-visibility.png?raw=true "Chat rooms collection")

      * To display the last person photo who entered the chat room:
        * Add `Backend Query`
        * `Query Collection`
        * `Collection Field` to users_public_data
        * `Query Type` to `Single Document`
        * Add a `Filter`
          * `Collection Field Name` to `userDocumentReference`
          * `Relation` to `Equal To`
          * `Vaue Source` to custom function named `userDocumentReferenceOfChatRoomLastEnter` and set its parameter:
            * `chatRoom` equal to `chat_rooms Document`

      Note if the chat room don't have any user yet or it has only one user yet, then the photo of the creator of the chatroom will be displayed. Furthermore, since the first image widget will display the photo of the last message sender, if the last message sender is the same with the last person who entered the chat room, the photo of the predecessor of the last person who entered the chat room will be displayed to avoid displaying the same image on the two image widgets.

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-enter-user-photo-backend-query.png?raw=true "Chat rooms collection")

      * To display the number of users in the group chat room:
        * Add `Container`
        * Inside the `Container` add `Text widget`
        * Set the `text widget's value` to the number of `userDocumentReferences` inside the chat_rooms document

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-number-of-users.png?raw=true "Chat rooms collection")
                
      * To display the group chat's title and the last message sent:
        * Add `Column`
        * Inside the `Column` add two text widgets

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-title-last-message-sent-column.png?raw=true "Chat rooms collection")

          * (top text widget) set its value to chat_rooms title

          ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-title-text.png?raw=true "Chat rooms collection")

          * (bottom text widget) set its value to chat_rooms last message

          ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-text.png?raw=true "Chat rooms collection")

      * To display the chat_rooms last message timestamp:
        * Add `Column` to the `Row`
        * Inside the `Column` add text widget
        * Set text widget's value to chat_rooms `lastMessageSentAt` timestamp with a format of M/d h:mm a

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage-timestamp.png?raw=true "Chat rooms collection")

        * Add conditional visibility to check if the `lastMessageSent` is set

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-timestamp-visibility.png?raw=true "Chat rooms collection")


### How to display menu when the chat message has tapped.

* Create a component that will accept `chatRoomMessageDocument` as parameter.
* Inside the component, put some widgets that will display the menu actions such as copy, edit, delete, open, etc.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-chat-message-menu-component.png?raw=true "Chat rooms collection")

* Inside the chat room, when the message has been tapped, open the component created above as a bottom sheet and pass the `chatRoomMessageDocument`.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat_room-message-tapped.png?raw=true "Chat rooms collection")





### How to leave a group chat room.

1. Close the dialog or drawer (if the button to leave the chat room is in a dialog or drawer)
2. Call the leave method of the ChatService and pass the chat room's document reference
3. Navigate to chat page with the replace route option enabled



### How to display an uploaded file.

1. Call the FireFlow DisplayMedia widget
2. Pass the required parameters such as width, height and url

### How to not invite the same user.

- When the user document reference is already in the chat room userDocumentReferences

### How to display the protocol message.

- When someone invited.
- When someone removed.
- When someone leave.

### How to remove a user


### How to receive and display the push notifications while the app is foreground.

### How to display the number of chat rooms with new messages.

- Use `ChatNoOfRoomsWithNewMessage` widget.

- It is counted by the number of rooms, not by the number of messages.
- It is done in steps, 
  - Listen for the changes of my chat rooms,
  - Count the number of rooms that don’t have my user document reference in `lastMessageSeenBy` field.



### How to query to the Open AI - GPT.

- If you don't want to implement GPT query, simply don't add the Open AI key and don't put options for GPT query.

### How to change chat room title



### How to send chat message

When a user inputs and sends a message, simply pass the input over the `onChatMessageSubmit`.




### How to create a group chat

Create `chat_rooms` document with fields and values of
moderatorUserDocumentReference as the creator’s reference
title as the title of the chat room
userDocumentReferences with the create’s reference.
lastMessageSentAt with Current Time (Not Firestore server timestamp)

Save the created document to `createdChatRoom` as action output


And navigate ChatRoom screen passing the `createdChatRoom` as chatRoomDocument parameter.



## Chat Design


### ChatRoomProtocolMessage








# Forum

## Forum Schema



### recentPosts

- See [recentPosts](#feed-recentposts).

- Create the `recentPosts` Date Types like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-recent-posts.jpg?raw=true "Recent posts")



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


## How to display feeds


### Display the recent feed

- To display the last post of the users that the login-in user follows,
  - Get the followings order by `lastPostCreatedAt`.
  - Display the feed in `lastPost`.


### Display the list of recent feeds

- To display the recent feeds(posts) of the users that the login-in user follows,
  - Call `UserService.instance.jsonFeeds` to get the list of the feeds and display.


# Files

## Storage Files Schema

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-storage-files.jpg?raw=true "Flutterflow storage_files schema")

 - `userDocumentReferences` is the uploader document reference.
 - `uid` it was the uploader uid.
 - `createdAt` is the timestamp it was created.
 - `contentType` is the mime type.
 - `size` is the file size.
 - `url` is the file url.
 - `fullPath` is the file full path.
 - `name` is the file name.
 - `type` is the file type base on contentType. If the `contentType` is `aplication/...`, then it will take the type of the file like `zip`, `pdf`, etc.
  
## Overview of file management

- If you(as an admin of your app) could see what files are uploaded, It would be helpful to manage.
- It would be helplful if you can
  - list images and videos to see if there are any malicious photos, videos.
  - list by size, file type, users.

- It is recommended to update the storage files list on desktop(or laptop) computer since it consumes more resouces.


## Logic of File management

Updating storage files

- Create Custom Action  
- Add fireflow as dependencies
- Add the following code

```dart
import 'package:fireflow/fireflow.dart';

Future updateStorageFiles() async {
  return StorageService.instance.updateStorageFiles();
}
```

- `StorageService.instance.updateStorageFiles()` will get all the files and store them into `/storage_files`.
  - See [Storage - List all files](https://firebase.google.com/docs/storage/flutter/list-files#list_all_files) and [Firestore - Batch Write](https://firebase.google.com/docs/firestore/manage-data/transactions#batched-writes).
  - Since it may consume some resources, it is a good idea to display a confirm dialog to update the list when the admin enters the page.
  - That's it. You can customize from here for your projects. See the `Customizing File Management`.

### Triggering UpdateStorageFiles


- Add page parameter named `firstEntry` with type `boolean` and set default value to `false`.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-first-entry.jpg?raw=true "Flutterflow storage_files firstEntry parameters")

- Select the base page in widget tree in the example it is named `AdminStorageFiles`, in the scaffold settings click `Actions` and click `Open` to open the action flow editor.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-on-page-load-click.jpg?raw=true "Flutterflow storage_files navigate on page load")

- Add `Condition` action and choose the `firstEntry` from parameters as conditional value.
- If `true`, Show an `Alert Dialog`(Confirm Dialog) asking if you want to update the Storage Files Information.
- If `true`, Call the custom action `updateStorageFiles` that we added. and show `alert dialog` that it was done updating.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-on-page-load.jpg?raw=true "Flutterflow storage_files confirmation action chain")

- To trigger the action we just need to define an action `Navigate to` page `Admin Storage Files`
- Pass the `firstEntry` parameter and set its value to `true`.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-navigate.jpg?raw=true "Flutterflow storage_files page navigate")

- When the page is loaded a Confirm Dialog should appear. Confirming if you want to update the current StorageFiles Information
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-confirm-dialog.jpg?raw=true "Flutterflow storage_files page navigate")

- Once done it should display another Alert Dialog displaying that the changes are now updated.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-success.jpg?raw=true "Flutterflow storage_files page navigate")


- Alternatively you can also add a `Button Widget` to trigger the same `action chain` without the `Condition` action for `firstEntry`. 
- Starting with the `Alert Dialog`(Confirm Dialog) to confirm if you want to update the storageFiles information.
- If `true`, call the custom action `updateStorageFiles` to update the `storageFiles` Information and show `Alert dialog` to confirm the changes.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-from-button-click.jpg?raw=true "Flutterflow storage_files update from button click")



## Customizing File Management

- Once you update(sync) the storage files into `/storage_files`, you have all the list of uploaded files with the fields of `url, uid, name, full path, size, contentType, type, createdAt`.
  - `type` is coming from the `contentType`.
    - It can be `image`, `video`, `audio`, `text`, etc.
    - If the `contentType` is `aplication/...`, then it will take the type of the file like `zip`, `pdf`, etc.
- You can search the `url` in firestore to know which document that it is attached to.

### Simple File Listing
- Add a `ListView Widget` to our page and add a Query.
- Select `Query Collection` from query type.
- Select `storage_files` from collection.
- Select `List of Documents` from return type.
- Optionally you can turn on `Enable Infinite Scroll` and add `Page Size`.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-simple-query.jpg?raw=true "Flutterflow storage_files simple query")

- Under the `ListView`
- We will add the [DisplayMedia widget](#displaymedia-widget) to show a preview of our file.
- Set the width and height
- Pass the file url to DisplayMedia Widget

  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-simple-page.jpg?raw=true "Flutterflow storage_files simple page")

### File Listing with Filters and Order

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-search-options.jpg?raw=true "Flutterflow storage_files search options")

Search Options

- We will search with the following filters

  - `userDocumentReference` filter user who upload the file
  - `type` filter by specific type
  - `createdAt` order by date and filtering with date
  - `size` order by size
  
  Since we are using firebase as our database we cant OrderBy the `createdAt` and `size` at the same time as it return undesirable results. What we will do is we will have different query filters to support order by `createdAt` and `size`. 


- To get `userDocumentReference`
  - Add a IconButton
  - Add an Action to show a buttomSheet and search for user
- Dropdown button with the list of `filetype`
- Dropdown button with list of possible Orderby
  
- DateRange Selection
  - `beginDate` DatePicker
  - `endDate` DatePicker
  
- Submit Button


Query Filter sample

- userDocumentReference, type, dateRange, CreatedAt Desc
- userDocumentReference, type, dateRange, CreatedAt Asc

- userDocumentReference, type, Size Desc
- userDocumentReference, type, Size Asc





















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




# Text translation support

- Why do we need another text translation support while flutterflow has one?
  - That is because we cannot translate a text that is dynamically generated and the fireflow displays somet text depending on its usage and it needs a way to show in the user's language.
- It is working by default whether the app uses it or not.
- To use the translation,
  - You can simply add translation data into the firestore.
  - Or you can use `Translation` widget to update the translation.
    - Only admin can create or delete.

## Putting translations directly into the Firestore

- Open Firebase console -> Firestore Database.
- Create a document `/system_settings/translations`.
- Add a document with
  - `Camera` as the key
  - `{ en: Camera, ko: 카메라 }` as the value in map.

Below is the example screen.
![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/firestore-translation.jpg?raw=true "Translation")



## Translate widget

- With `Translate` widget, you can
  - add
  - search
  - delete
  the translations.


## List of translations


- Below are the necessary translation codes for media upload.
  - `Choose Source`
  - `Gallery (Photo)`
  - `Gallery (Video)`
  - `Gallery`
  - `Camera`
  - `Upload Any File`
  - `Success to upload media`
  - `Failed to upload media`





# Widgets

## Custom Popup widget.

FF provides the bottom sheet widget. But it is a bit different from the popup menu.

So, I made a widget named `CustomPopup` that does something like the popup menu in the following screenshot.

Ex) Chat room screenshot

In the screenshot, I display the members of the chat room. Yes, it is a real popup menu and all the designs are coming from Components. You can add custom design and actions as you want.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup.gif?raw=true "Custom Popup")

### Custom Popup Tips

- When you want to display dynamic content in the popup box, you would set the width and height bound on the popup box. Or you would see an error of `NEEDS-LAYOUT NEEDS-PAINT`.

### How to implement the custom ppup

- For your information, When you create a Component, you can use that Component in a Custom widget. You need to check `Exclude from Compile` in this case.


- The child widget is the Component that displays as a trigger. The child component in the screenshot above is the widget that has two photos. In the component, the first user is the user who sent the last message. The second user is the user who last entered the chat room.


- When a user taps on the Component, a popup menu is shown. And the popup menu is the ChatGroupUsers Component.


- You can make your own child Component and the popup Component with your own design and actions. Just the way you develop your Component.
  - And passed them over the CustomPopup widget.

- Don't put the size of the width in the popup component. Or put it as `inf`. The width of the popup component meant to be automatically sized by the `CustomPopup` widget. See [the popup component width size issue](https://github.com/withcenter/fireflow/issues/1).

- Options
  - dx is the x position where the popup would appear.
  - dy is the y position where the popup would appear.


```dart
import 'package:app/components/icon_component_widget.dart';
import 'package:app/components/popup_component_widget.dart';
import 'package:fireflow/fireflow.dart';
 
class PopupExample extends StatefulWidget {
 const PopupExample({
   Key? key,
   this.width,
   this.height,
 }) : super(key: key);
 
 final double? width;
 final double? height;
 
 @override
 _PopupExampleSate createState() => _PopupExampleSate();
}
 
class _PopupExampleSate extends State<PopupExample> {
 @override
 Widget build(BuildContext context) {
   return CustomPopup(
     dx: 32,
     dy: 38,
     child: IconComponentWidget(),
     popup: PopupComponentWidget(),
   );
 }
}
```

- It can go much complicated customization like below.
  - The custom widget `DisplayChatUsers` below takes a parameter of `chatRoom` and it passes over the child widget and popup widget. Then, the child and popup widget may display different information.

```dart
import '../../components/chat_group_user_icons_widget.dart';
import '../../components/chat_group_users_widget.dart';
import 'package:fireflow/fireflow.dart';
 
class DisplayChatUsers extends StatefulWidget {
 const DisplayChatUsers({
   Key? key,
   this.width,
   this.height,
   required this.chatRoom,
 }) : super(key: key);
 
 final double? width;
 final double? height;
 final ChatRoomsRecord chatRoom;
 
 @override
 _DisplayChatUsersState createState() => _DisplayChatUsersState();
}
 
class _DisplayChatUsersState extends State<DisplayChatUsers> {
 @override
 Widget build(BuildContext context) {
   return CustomPopup(
     dx: 32,
     dy: 38,
     child: ChatGroupUserIconsWidget(
       chatRoom: widget.chatRoom,
       width: 80,
       iconSize: 42,
     ),
     popup: ChatGroupUsersWidget(
       chatRoom: widget.chatRoom,
     ),
   );
 }
}
```



### Custom poup step by step example


#### Create a child Component

The child component is the widget that will trigger a popup menu to be appeared when a user presses on.

Example)

Just create an icon, or a text or any. You can do whatever design you like, but don’t put a widget that has tap event handler like a button.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup-1.jpg?raw=true "Custom Popup")



#### Create a popup Component

Create a component that will appear as a popup menu. You can do whatever design you want and you can add whatever actions you like. And yes, it works just as you expect.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup-2.jpg?raw=true "Custom Popup")


#### Custom widget for Custom Popup

- Create a custom widget to make the child Component and the popup Component work together

The difficult part may be creating the custom widget to make the two widgets work together.

I named the custom widget as `ChatRoomMenu`. So, the following code snippet contains `ChatRoomMenu` as its class name.

The see import statement. The patterns of the import path are
Add `../../components/` in front.
Then, add the kebab case of the Component.
Lastly, add `_widget.dart`.

You will need to import package:fireflow.fireflow.dart for fireflow.

And in the body of the state class, use CustomPopup with child and popup parameters with its respective Components.

And finally, on the Widget Settings.
I checked `Exclude from compilation`. This is needed when you refer to codes that are generated by FlutterFlow itself like accessing Components.
And I added `fireflow` as its dependency. You may leave the version empty. Note that, when you change the version of fireflow in one place, the version of other places will follow.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup-3.jpg?raw=true "Custom Popup")


#### Add the custom widget in your design

Now, the easiest part. Just add the custom widget where you want to add.
For the example of the code above, the Custom widget is ChatRoomMenu. And I added at the top-right corner.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup-4.jpg?raw=true "Custom Popup")


## DisplayMedia widget

This widget accepts a String of URL together with width and height.

The width and height are respected to size the DisplayMedia widget.

This widget displays any kind of url like photo, video, audio, txt, pdf, etc.

See the details on the [API reference - MediaDisplay](https://pub.dev/documentation/fireflow/latest/fireflow/DisplayMedia-class.html).


Below is an example of displaying media by giving a photo url. 


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/display-media-1.jpg?raw=true "Display Media")

To make the border round like above,


Disable `Enforce Width and Height`


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/display-media-2.jpg?raw=true "Display Media")


And wrap it with a container, put border property, and enable `Clip Content`.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/display-media-3.jpg?raw=true "Display Media")



The DisplayMedia widget of Fireflow displays files like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/display-media-4.jpg?raw=true "Display Media")



It displays the file of the given url but does not react on tap. So, it is up to you how you want to design your app.


## SafeArea widget

You can Enable/Disable the SafeArea in FF. But you cannot give SafeArea on top only or bottom only. And you cannot optionally add a space to make the contents(widgets) appear safely from the notches.

For instance, you want to design your app with an image that displays as a background of the full screen. In this case you have to disable the SafeArea. But you need it enabled for some devices that have notches.

In the example below;

Some devices like the one on the left side have no notches. That’s fine without SafeArea.
But some devices like the one on the right have notches at the top and at the bottom. 

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-1.jpg?raw=true "SafeArea")


Yes, of course, you may twist the widgets to make the full screen with a background image like below. But that has limitations and the widget tree goes crazy.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-2.jpg?raw=true "SafeArea")


So?

Here comes with the two widgets. SafeAreaTop and SafeAreaBottom.

Here is how to create SafeAreaTop and SafeAreaBottom widgets using Fireflow.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-3.jpg?raw=true "SafeArea")


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-4.jpg?raw=true "SafeArea")

How to layout the SafeAreaTop and SafeAreaBottom widgets.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-5.jpg?raw=true "SafeArea")

Be sure that you disable the `Enforce Width and Height` option.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/safearea-6.jpg?raw=true "SafeArea")


# Actions


## snackBarSuccess

The snackbar in the flutterflow is okay. But I want to have my own design of snackbars. So, here are the two. It's relatively easy to apply the snackbar.

Example custom action code for applying fireflow snackbar.
```dart
import 'package:fireflow/fireflow.dart';

Future snackBar(
  BuildContext context,
  String title,
  String message,
) async {
  // Add your function code here!
  snackBarSuccess(context: context, title: title, message: message);
}
```

The snackbar applied to the app.
![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-1.jpg?raw=true "Snackbar")


Add snackBarSuccess Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-2.jpg?raw=true "Snackbar")

## snackBarWarning

Add snackBarWarning Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-3.jpg?raw=true "Snackbar")



# Functions

## Country Code

- You can display a list of favorite countries on top with divider.
  - For favorites, you can add dial_code or country name in the list. And the country name in favotes is case sensitive.


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-dial-code-picker-code-expression.jpg?raw=true "Country Dial Code Picker")


# Testing

The current version of fireflow has no backend. ([The previous version of fireflow](https://github.com/thruthesky/fireflow_202211/tree/main/functions/src) was developed heavily based on Cloud Functions.) Now in this version, it simply works as a custom action and the most of the complicated logic goes under the scene. Yes, we need tests to give some trust on our code. And it's a bit different from the standard Flutter test.

- [Firestore security rule - unit test](https://github.com/withcenter/fireflow/blob/main/firebase/firestore/tests/test.spec.js).
- [Unit test and Widget test](https://github.com/withcenter/fireflow/tree/main/test).
  - These unit tests and widget tests follow the [flutter standart testing](https://docs.flutter.dev/cookbook/testing/widget/introduction) mechanism.
  - To run the test, simply run the `flutter test` command.
- Fireflow has its own unit test to make it easy for running the test on the real servers. It's called [fireflow real test](#fireflow-real-test).

## Fireflow real test

- Fireflow needs the tests run in the full functional app features and servers. The Integration test is too slow and I cannot work with it. So, I made one by myself. The test runs after boot or by manual trigger. And it does not report the test result. So, it's not fit for the test in CI/CD pipeline. But will do the unit test.
- See [the source code for fireflow real test](https://github.com/withcenter/fireflow/blob/main/example/lib/test.dart).
- To make it run,
  - You may need to set the `key.dart` file for the keys that you are going to test. (You may probably not need it)
  - Hot restart after updating the code.

# Developer coding guide


## Developing with Fireflow

If you want to update/improve the fireflow or if you want to work on your project other with fireflow, then follow the steps below.

1. Fork fireflow.
2. Clone fireflow from the fork.
3. Create your own branch.
4. Clone your project under `<fireflow>/apps` folder.
5. Change the path of fireflow package to `path: ../..` in the pubspec.yaml of your project.
6. One you have updated fireflow, create PR.


## Development tips

### Safe string

- In some cases the string should be in a moderate format. Like when the post content is delivered over push notification, it should not be too long and should not contain any special characters, nor HTML tags.
- To use the user input value over those cases, fireflow uses the [`safeString` function](https://pub.dev/documentation/fireflow/latest/fireflow/safeString.html).

# Sponsors

FlutterFlow Korean Community




# Known Issues

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
