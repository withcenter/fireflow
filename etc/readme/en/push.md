# Push notification

There are some differences from the notification logic of FF.

- The push notification sender's user reference is added to the parameter.
- The sender’s user document reference is always removed. Meaning, the sender will not receive the push notification he sent.
- Foreground push notification works.


## Enable Push notifications

- The fireflow is tightly coupled with the Push Notification as of now. So, you need to enable push notification on Flutterflow.


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

