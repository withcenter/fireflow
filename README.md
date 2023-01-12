
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
- [User](#user)
- [Chat](#chat)
  - [Chat schema](#chat-schema)
  - [How to display menu when the chat message has tapped.](#how-to-display-menu-when-the-chat-message-has-tapped)
  - [How to leave a group chat room.](#how-to-leave-a-group-chat-room)
  - [How to display an uploaded file.](#how-to-display-an-uploaded-file)
  - [How to not invite the same user.](#how-to-not-invite-the-same-user)
  - [How to display the protocol message.](#how-to-display-the-protocol-message)
  - [How to remove a user](#how-to-remove-a-user)
- [Push notification](#push-notification)
  - [How to receive and display the push notifications while the app is foreground.](#how-to-receive-and-display-the-push-notifications-while-the-app-is-foreground)
  - [Displaying the number of chat rooms with new messages.](#displaying-the-number-of-chat-rooms-with-new-messages)
  - [Querying to the Open AI - GPT.](#querying-to-the-open-ai---gpt)
- [Supabase](#supabase)
- [Widgets](#widgets)
  - [Custom Popup widget.](#custom-popup-widget)
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


# User

- Create the `users` schema in Flutterflow.

/users_public_data collection

When you need to get the user’s public data document, use `usersPublicDataDocumentReference` in `Authenticated User`.
uid
String
The user’s uid
userDocumentReference
Doc Reference (users)
The user’s document reference
displayName
String
The user’s display name
photoUrl
Image Path
Primary profile photo url
registeredAt
Timestamp
The time that this document was created.
updatedAt
Timestamp
The time that this document was updated.
gender
String
M as Male or F as Female
birthday
Timestamp
Birthday of the user
followers
List< Doc References (users) >
Document reference of users who follow me.
hasPhoto
Boolean
True if the user has the primary profile photo. Or false.
isProfileComplete
Boolean
True if the user filled in the necessary fields in his profile. Or false.
coverPhotoUrl
Image Path
The cover photo url of the user
recentPosts
List< Data (recentPosts) >
The last 50 recent posts of the user.
Note, create /posts collections and `recentPosts` Data Type first to add this field.
lastPostCreatedAt
Timestamp
The time that the user created the last post.
isPremiumUser
Boolean
True if the user is paid for premium service.










# Chat

## Chat schema

- Chat service needs two collections.

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


# Push notification


## How to receive and display the push notifications while the app is foreground.

## Displaying the number of chat rooms with new messages.

## Querying to the Open AI - GPT.

# Supabase

- To enable supabase, follow [the Supabase document in the offical site](https://docs.flutterflow.io/data-and-backend/supabase).

- Add `supabase: true` on `AppService`.

- And prepare `users_public_data` schema like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-supabase.jpg?raw=true "Supabase")



# Widgets

## Custom Popup widget.





# Sponsors

FlutterFlow Korean Community


