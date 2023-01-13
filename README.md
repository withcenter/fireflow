
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

[English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/ko/README.md)

# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is especially designed to work with `FlutterFlow`. You may use it with `Flutter` as you wish.


- [Fireflow](#fireflow)
- [Overview](#overview)
- [Features](#features)
  - [What's coming](#whats-coming)
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
  - [Profile photo upload](#profile-photo-upload)
  - [Adding extra fields on users\_public\_data schema](#adding-extra-fields-on-users_public_data-schema)
- [System setting](#system-setting)
  - [Admin](#admin)
- [Push notification](#push-notification)
  - [Foreground Push Notification and Routing](#foreground-push-notification-and-routing)
  - [MessageModel](#messagemodel)
- [Chat](#chat)
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
  - [Forum Category Logic](#forum-category-logic)
- [Supabase](#supabase)
- [Widgets](#widgets)
  - [Custom Popup widget.](#custom-popup-widget)
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
- [Developer coding guide](#developer-coding-guide)
- [Sponsors](#sponsors)
- [Known Issues](#known-issues)
  - [Push notification and back navigation](#push-notification-and-back-navigation)
  - [\[cloud\_firestore/permission\_denied\] The caller does not have permission to execute the specified operation.](#cloud_firestorepermission_denied-the-caller-does-not-have-permission-to-execute-the-specified-operation)


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
    - Tap on chat message to delete, edit, copy, open, etc.
  - Push notification. User can subscribe/unsubscribe chat room.
  - Display the number of chat room that has unread messages.
  - Open AI. GPT query. Chat members can query to GPT and share.
  - Uploading any kinds of files like Image, Video, TXT, PDF, ZIP, etc.
  - User invite and leave in Group chat.
  - Moderator can remove a user.


- Push Notification.
  - Sending push notification is handled by fireflow.
  - Display the foreground push notification on the top snackbar.

- Enhanced Firestore Security Rules

- Custom widgets

## What's coming

- Forum
  The complete forum functionality including;
  - Category management
  - User role management
  - Post and comment management including
    - Nested (threaded) comments
  - Push notification
    - Subscribing/Unsubscribing a category
    - Sending push notifications to the author of the parent comments and post.

- Hard limit on wait minutes for post creation.
  - Add a security rules for timestamp check.

- Optional push notification.
  - There will be an option to enable or disable push notification.

- Chat
  - Block the moderator to leave the chat room when there are other members in the room.
  - Destroying the chat room. The fireflow will automatically remove all users and delete the chat room.
  - Block users not to enter the chat room. `blockUsers` will hold the list of the blocked users.
  - Sending push notification to all users including those who are unsubscribed the chat room.

- Since the `AppCheck` is built-in by Flutterflow, why don't fireflow remove the security rules and `/users_public_data`?


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


![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-users-schema.jpg?raw=true "Flutterflow users schmea")


- Add `userPublicDataDocumentReference` to `users` schema. This is the connection to `users_public_data` schema.

- Add `admin` boolean. If this is set to true, the user will see admin menu. To give the user admin permission, you need to add the uid of the user into the system_settings collection.


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


## Profile photo upload

- Uploading the profile photo of the user is much complicated than you may think.
  - If a user cancels on the following(immediate) upload after the user has just uploaded a profile photo, the app maintains the same URL on the widget state. So, it should simply ignore when the user canceled the upload.
  - The existing profile photo should be deleted (or continue to work) even if the actual file does not exist. There might be some cases where the photo fields have urls but the photos are not actually exists and this would cause a problem.


- When the user uploads his profile photo, use the `Upload Media Action` in fireflow (not in flutterflow), then pass the uploaded URL to `afterProfilePhotoUpload`. And leave all the other works to fireflow.

- For cover photo upload, update the photo using `Upload Media Action` in fireflow and url to `afterCoverPhotoUpload` action.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-photo.jpg?raw=true "User photo")


## Adding extra fields on users_public_data schema

- You can simply add more fields on users_public_data schema.



# System setting

Some API Keys like Open AI will be invalid once it is open to the public. So, it needs to be kept in the database (or somewhere else).

In Fireflow, those keys should be in /system_settings/keys { keyName: … }



## Admin


To set a user as an admin, You need to update the Firestore directly. You can do so within FF settings, or Firestore.

You need to add your UID (Or any other user’s UID that you want to set as an admin)
at /system_settings/admins { <USER_UID>: true }

You need to add {admin: true} in the `/users/{uid} {admin: true}` document. It's `/users` collection. Not the `/users_public_data` collection.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/set-admin.gif?raw=true "How to set admin")




# Push notification

There are some differences from the notification logic of FF.

- The push notification sender's user reference is added to the parameter.
- The sender’s user document reference is always removed. Meaning, the sender will not receive the push notification he sent.
- Foreground push notification works.


## Foreground Push Notification and Routing

It is not ideal to do routings inside fireflow.
You can handle the tap event on push notification by adding `onTapMessage` callback to AppService.


## MessageModel

The `MessageModel` will handle all kinds of push notification data including, but not limited to chat, post, profile.




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

Get the chat rooms that have the login user’s document reference in the `userDocumentReferences` field.


### How to display menu when the chat message has tapped.

- message copy, edit, delete, open, etc.

### How to leave a group chat room.


### How to display an uploaded file.

### How to not invite the same user.


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

The recent 50 posts of each users wil be saved in `recentPosts`.

- Create the `recentPosts` Date Types like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-recent-posts.jpg?raw=true "Recent posts")


## Forum Category Logic

- Fireflow creates its category document with the document id as the category itself. For instance, if the category is `qna`, the document path will be `/categories/qna`. The is because
  - it's easy to specify the category directly into the UI builder. For instance, you want to display the QnA forum, then you can pass `qna` as the category parameter. If you don't use the category as its document id, then the logic would get complicated to get the document id of `qna`.
  - it's easy to design the firestore security rules.



# Supabase

- To enable supabase, follow [the Supabase document in the offical site](https://docs.flutterflow.io/data-and-backend/supabase).

- Add `supabase: true` on `AppService`.

- And prepare `users_public_data` schema like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-supabase.jpg?raw=true "Supabase")



# Widgets

## Custom Popup widget.

FF provides the bottom shee widget. But it is way different from the popup menu.

So, I made a widget named `CustomPopup` that does something like the popup menu in the following screenshot.

Ex) Chat room screenshot

In the screenshot, I display the members of the chat room. Yes, it is a real popup menu and all the designs are coming from Components. You can add custom design and actions as you want.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/custom-popup.gif?raw=true "Custom Popup")


### How to implement the custom ppup

- For your information, When you create a Component, you can use that Component in a Custom widget. You need to check `Exclude from Compile` in this case.


- The child widget is the Component that displays as a trigger. The child component in the screenshot above is the widget that has two photos. In the component, the first user is the user who sent the last message. The second user is the user who last entered the chat room.


- When a user taps on the Component, a popup menu is shown. And the popup menu is the ChatGroupUsers Component.


- You can make your own child Component and the popup Component with your own design and actions. Just the way you develop your Component.
  - And passed them over the CustomPopup widget.


- Options
  - dx is the x position where the popup would appear.
  - dy is the y position where the popup would appear.


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

The widget and height is used to size video.

This widget displays any kind of url like photo, video, audio, txt, pdf, etc.


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

The snackbar in FF is okay. But I want to have my own design of snackbars. So, here are the two. It's relatively easy to design the snackbar.


## snackBarSuccess

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-1.jpg?raw=true "Snackbar")


Add snackBarSuccess Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-2.jpg?raw=true "Snackbar")

## snackBarWarning

Add snackBarWarning Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-3.jpg?raw=true "Snackbar")


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

