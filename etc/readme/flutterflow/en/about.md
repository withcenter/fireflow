# About the FireFlow

## Overview

Flutterflow is a gorgeous platform to build mobile apps rapidly. The developers can build whatever apps they like without any limitations.

Flutterflow comes easy when the project is relatively small. But when the project grows with complicated functionalities and logics, you will feel the pressure of what the professional developer feels.

To make the apps fully functional, the developers definitely need the use of custom code. It's important, but many of Flutterflow developers are stuck with Custom functions, custom widgets, and custom actions.  That's where **Fireflow** came in.

Fireflow encapsulates all the complicated logics and serve most of the common use cases. Use it build professional apps like chat apps, SNS apps, community apps, and more.

## Features

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
