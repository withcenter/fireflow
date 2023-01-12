
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

[English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/ko/README.md)

# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is especially designed to work with `FlutterFlow`. You may use it with `Flutter` as you wish.


- [Fireflow](#fireflow)
- [Overview](#overview)
- [Features](#features)
  - [The Coming Features](#the-coming-features)
- [Getting started](#getting-started)
  - [Setting up Firebase](#setting-up-firebase)
    - [Firestore Security Rules](#firestore-security-rules)
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
- [Push notification](#push-notification)
- [Chat](#chat)
  - [Chat schema](#chat-schema)
    - [Chat Room collection](#chat-room-collection)
    - [Chat message collection](#chat-message-collection)
  - [How to display menu when the chat message has tapped.](#how-to-display-menu-when-the-chat-message-has-tapped)
  - [How to leave a group chat room.](#how-to-leave-a-group-chat-room)
  - [How to display an uploaded file.](#how-to-display-an-uploaded-file)
  - [How to not invite the same user.](#how-to-not-invite-the-same-user)
  - [How to display the protocol message.](#how-to-display-the-protocol-message)
  - [How to remove a user](#how-to-remove-a-user)
  - [How to receive and display the push notifications while the app is foreground.](#how-to-receive-and-display-the-push-notifications-while-the-app-is-foreground)
  - [Displaying the number of chat rooms with new messages.](#displaying-the-number-of-chat-rooms-with-new-messages)
  - [Querying to the Open AI - GPT.](#querying-to-the-open-ai---gpt)
- [Forum](#forum)
  - [Forum Schema](#forum-schema)
    - [recentPosts](#recentposts)
- [Supabase](#supabase)
- [Widgets](#widgets)
  - [Custom Popup widget.](#custom-popup-widget)
- [Developer coding guide](#developer-coding-guide)
- [Sponsors](#sponsors)


# Overview

Flutterflow is a gorgeous platform to build mobile apps rapidly. Flutterflow developers can build whatever apps they want without limitation.

Flutterflow comes easy when the project is relatively small. But when the project grows with complicated functionalities and logics, you will feel the pressure of what professional developers feel.

Many of Flutterflow developers are stuck with Custom functions, custom widgets, custom actions. They are ultimately important to make your app fully functional. There are helper tools and Flutterflow to build custom code easily. But often, we as Flutterflow developers need more to make it easy and use. And what’s worse is that the more the logic becomes complicate, the more you would stuck in the custom coding.

That’s why **Fireflow** came out.

Fireflow encapsulates all the complicated logics and is made easy to reuse. Yes, it’s for you if you want to build professional apps like chat apps, SNS apps, community apps, and more.

It’s open source and you can use it for free. The document is written in detail. And you can ask anything about Fireflow.

I make sample projects and sell it by cloning in Flutterflow.


# Features

- Enhanced user management.
  - The documents of the `/users` collection have private information and shouldn't be disclosed. But the user information is needed to be disclosed for the most app features. To make it happen, I created another collection named `/users_public_data` that does not hold user's prviate informatio.

- Chat.
  - Custom design.
  - Push notification. User can subscribe/unsubscribe chat room.
  - Display the number of chat room that has unread messages.
  - Open AI. GPT query. Chat members can query to GPT and share.
  - Uploading any kinds of files like TXT, PDF, ZIP, etc.
  - User invite and leave in Group chat.
  - Moderator can remove a user.


- Push Notification.
  - Sending push notification is handled by fireflow.
  - Display the foreground push notification on the top snackbar.

- Enhanced Firestore Security Rules

- Custom widgets

## The Coming Features

- Forum
  The complete forum functionality including;
  - Category management
  - User role management
  - Post and comment management including
    - Nested (threaded) comments
  - Push notification
    - Subscribing/Unsubscribing a category
    - Sending push notifications to the author of the parent comments and post.

- Optional push notification.
  - There will be an option to enable or disable push notification.

- Chat
  - Block the moderator to leave the chat room when there are other members in the room.
  - Destroying the chat room. The fireflow will automatically remove all users and delete the chat room.
  - Block users not to enter the chat room. `blockUsers` will hold the list of the blocked users.
  - Sending push notification to all users including those who are unsubscribed the chat room.



# Getting started

To get started, you would need to install the necessary parts of the Fireflow.

## Setting up Firebase

### Firestore Security Rules

Fireflow has its own Firestore Security Rules. To apply it, you will need to check the `Exclude` buttons on the Collections like below. 

![Flutterflow Firestore Deploy](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-firestore-deploy-1.jpg?raw=true)

And copy the [fireflow security rules](https://raw.githubusercontent.com/withcenter/fireflow/main/firebase/firestore.rules) and paste it into your Firebase firestore security rules.

![Firestore Security Rules](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/firestore-rules.gif?raw=true)

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
    onTapMessage: (initialPageName, _parameterData) async {
      try {
        final parametersBuilder = parametersBuilderMap[initialPageName];
        if (parametersBuilder != null) {
          final parameterData = await parametersBuilder(_parameterData);
          context.pushNamed(
            initialPageName,
            params: parameterData.params,
            extra: parameterData.extra,
          );
        }
      } catch (e) {
        print('Error: $e');
      }
    },
  );
}
```

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


## Local State Variable

There are few local state variables that Fireflow uses.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-local-states-2.jpg?v=2&raw=true "Local State Variables")

- `defaultImagePath` is the image path that will be used by default. For instance, when you add a Image widget and sometimes it needs the default image.
- `anonymousMaleUrl` is the male picture url that will be shown by default when the user is male and has no profile photo.
- `anonymousFemaleUrl` is the female picture url that will be used when the user is female and has no profile photo.
- `chatSendMessageAskResult` is the state that will hold the result of chat send option. When the user sends a message, he can choose an option whether to query to GPT or not.
- `gptLoader` is the state that when the user query to GPT, it will show the loading indicator.


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



## users_public_data schema

- Since `users` collection has private information like email and phone number, fireflow saves public information into `users_public_data` collection.

- Create the `users_public_data` schema in Flutterflow like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-users_public_data-schema.jpg?raw=true "Flutterflow users_public_data schmea")


- `uid` is the the uid of the user.
- `userDocumentReference` is the document reference of the user.
- `displayName` is the display name of the user.
- `photoUrl` is the primary profile photo url of the user.
- `registeredAt` is the time that this document was created.
- `updatedAt` is the time that this document was updated.
- `gender` can be one of `M` or `F`. M as Male or F as Female
- `birthday` is the birthday of the user
- `followers` is the list of user document references who follow the user.
- `hasPhoto` is set to `true` if the user has the primary profile photo. Or false.
- `isProfileComplete` is set to `true` if the user filled in the necessary fields in his profile. Or false.
- `coverPhotoUrl` is the url of the cover photo of the user.
- `recentPosts` is the list of the last recent 50 document references that the user posts. Note, create /posts collections and `recentPosts` Data Type first to add this field.
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



# Push notification




# Chat

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




## How to display menu when the chat message has tapped.

- message copy, edit, delete, open, etc.

## How to leave a group chat room.


## How to display an uploaded file.

## How to not invite the same user.


## How to display the protocol message.

- When someone invited.
- When someone removed.
- When someone leave.

## How to remove a user


## How to receive and display the push notifications while the app is foreground.

## Displaying the number of chat rooms with new messages.

## Querying to the Open AI - GPT.

- If you don't want to implement GPT query, simply don't add the Open AI key and don't put options for GPT query.

# Forum

## Forum Schema

### recentPosts

The recent 50 posts of each users wil be saved in `recentPosts`.

- Create the `recentPosts` Date Types like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-recent-posts.jpg?raw=true "Recent posts")




# Supabase

- To enable supabase, follow [the Supabase document in the offical site](https://docs.flutterflow.io/data-and-backend/supabase).

- Add `supabase: true` on `AppService`.

- And prepare `users_public_data` schema like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-supabase.jpg?raw=true "Supabase")



# Widgets

## Custom Popup widget.




# Developer coding guide

If you want to update/improve the fireflow or if you want to work on your project other with fireflow, then follow the steps below.

1. Fork fireflow.
2. Clone fireflow from the fork.
3. Create your own branch.
4. Clone your project under `<fireflow>/apps` folder.
5. Change the path of fireflow package to `path: ../..` in the pubspec.yaml of your project.
6. One you have updated fireflow, create PR.


# Sponsors

FlutterFlow Korean Community


