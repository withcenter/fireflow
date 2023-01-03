
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

# Fireflow

* `Fireflow` is an open source, easy and rapid development tool to build apps like social network service, forum based community service, online shopping service, and much more.

* `Fireflow` is especially designed to work with `FlutterFlow`.

* `Fireflow` covers from the backend work like supporting forum management with custom security rules to the frontend work like providing `CustomPopup` widget.



## Getting started

The fireflow has lots of features and large amount of documentation. To make it easy to keep the documentaion simple, I have wrote a separate document.

Please see the [Fireflow document](https://docs.google.com/document/d/e/2PACX-1vQXcu36d1ojHEoi1lh3UNKXnDrfRtb_7J4j7GmTsc1eS2LdLMoggA2KfMqGpE3L4PaYNmCHDhGn6SEm/pub)

## Features

- Enhanced user management.
  - The documents of the `/users` collection have private information and shouldn't be disclosed. But the user information is needed to be disclosed for the most app features. To make it happen, I created another collection named `/users_public_data` that does not hold user's prviate informatio.

- Enhanced chat.
  - Custom design
    - Custom design means, adding buttons for edit and delete.

- Complete forum functionality including;
  - Category management
  - User role management
  - Post and comment management including
    - Nested (threaded) comments
  - Push notification
    - Subscribing/Unsubscribing a category
    - Sending push notifications to the author of the parent comments and post.


- Enhanced Firestore Security Rules

- Enhanced Push Notification
  - Subscription for forum category, chat room, etc.
  - Foreground push notification.


- Custom widgets

