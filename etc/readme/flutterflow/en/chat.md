# Chat

## Chat Overview

- There are two types of chat room.
  - One is the one to one chat
  - The other is the group chat.

## Chat schema

- Chat service needs two collections.

### Chat Room collection


Schema **chat_rooms**

|Field Name | Data Type |
|--------|-------:|
| id | String |
| userDocumentReferences | List < Doc Reference (users) > |
| lastMessage | String |
| lastMessageUploadUrl | String |
| lastMessageSentAt | Timestamp |
| lastMessageSeenBy | List < Doc Reference (users) > |
| lastMessageSentBy | Doc Reference (users) |
| title | String |
| unsubscribedUserDocumentReferences | List < Doc Reference (users) > |
| moderatorUserDocumentReferences | List < Doc Reference (users) > |
| isGroupChat | Boolean |
| isOpenChat | Boolean |
| reminder | String |
| lastMessageUploadUrl | String |
| backgroundColor | String |
| urlClick | Boolean |
| urlPreview | Boolean |
| isSubChatRoom| Boolean |
| parentChatRoomDocumentReference | Doc Reference (chat_rooms) |
| subChatRoomCount | Integer |
| isSubChatRoom | Boolean |
| noOfMessages| Integer |
| readOnly | Boolean |







- `id` is the id of the chat_rooms document itself.
- `userDocumentReferences` is the participants document reference of the chat room.
- `lastMessage` is the last chat message if the user sent a text.
- `lastMessageUploadUrl` is the url of the upload if the user uploaded a file(photo).
- `lastMessageSentAt` is the timestamp of last message
- `lastMessageSeenBy` is the list of user reference who have read the message
- `lastMessageSentBy` is the user reference of the last chat message sender.
- `title` is the chat room title. The moderator can change it.
- `moderatorUserDocumentReferences` is the user document references of the moderators. The first user who created the chat room becomes a moderator automatically. And he can add more moderators.
- `unsubscribedUserDocumentReferences` is the document references of the users who disabled the notification of a new message for the chat room.
- `isGroupChat` is set to `true` if it's a group chat. Otherwise, false.
- `isOpenChat` is set to `true` if the chat room is open to anyone. When it is set to true, users can join the chat room.
- `urlClick` is set to `true` if the moderator lets users click the url.
- `urlPreview` - Set it to `true` to show the preview of the url link.
- `isSubChatRoom` - If the chat room is a sub chat room, then it is set to true.
- `parentChatRoomDocumentReference` - This is the parent chat room document reference if the sub chat group functionality is enabled.
- `isSubChatRoom` - This is `true` when the chat room is a sub chat room of a parent chat room. (updated by `ChatService.instance.chatRoomAfterCreate`)
- `subChatRoomCount` - This has no the number of the sub chat room if the chat room is a parent chat room. (updated by `ChatService.instance.chatRoomAfterCreate`). `isSubChatRoom` field is set in `catRoomAfterCreate`. But it is also set in `ChatMessageList` widget.
- `noOfMessages` - This has the total number of messages that were sent by the users in the room. You may use this to display as favorites chat rooms. For instance, you want to display 10 1:1 chat rooms ordered by the no of messages.
- `readOnly` is set to true when the moderator of the chat room set it to read only. Then, the users in the room can only read. Moderators can write.
- `createdAt` is the time that the chat room is created.


### Chat message collection

Schema **chat_room_messages**

|Field Name | Data Type |
|--------|-------:|
| userDocumentReference | Doc Reference (users) |
| chatRoomDocumentReference | Doc Reference (chat_rooms) |
| text | String |
| sentAt | Timestamp |
| uploadUrl | String |
| uploadUrlType | String |
| protocol | String |
| protocolTargetUserDocumentReference | Doc Reference (users) |
| previewUrl | String |
| previewTitle | String |
| previewDescription | String |
| previewImageUrl | Image Path |
| replyDisplayName | String |
| replyText | String |


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

- When there is a url in the text, the fireflow will save the url preview information at `previewUrl`, `previewTitle`, `previewDescription`, `previewImageUrl`. If there is no url in the text or it cannot save preview informatin, the fields become empty string.
  - The `previewDescriptoin` has the full description from the site. If you need to cut it short, you may use a custom fuction (or a code expression).

- `replyDisplayName` is the name of the message in reply. A user can reply on another message. And it is the name of the other message.
- `replyText` is the message of the reply.



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

- Use `ChatNoOfRoomsWithNewMessage` widget like below.

```dart
import 'package:fireflow/fireflow.dart';

class NoOfNewChatRoom extends StatefulWidget {
  const NoOfNewChatRoom({
    Key? key,
    this.width,
    this.height,
    this.textSize,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? textSize;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  _NoOfNewChatRoomState createState() => _NoOfNewChatRoomState();
}

class _NoOfNewChatRoomState extends State<NoOfNewChatRoom> {
  @override
  Widget build(BuildContext context) {
    return ChatNoOfRoomsWithNewMessage(
      width: widget.width,
      height: widget.height,
      textSize: widget.textSize,
      backgroundColor: widget.backgroundColor,
      textColor: widget.textColor,
    );
  }
}
```

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-new-chat-room.jpg?raw=true "No of new chat rooms")


- It is counted by the number of rooms, not by the number of messages.
- It is done in steps, 
  - Listen for the changes of my chat rooms,
  - Count the number of rooms that don’t have my user document reference in `lastMessageSeenBy` field.




### How to query to the Open AI - GPT.

- If you don't want to implement GPT query, simply don't add the Open AI key and don't put options for GPT query.

### How to change chat room title



### How to send chat message

When a user inputs and sends a message, simply call the `ChatService.instance.sendMessage()` method.
You can create a custom action `onChatMessageSubmit` that wraps the `ChatService.instance.sendMessage()` method.

```dart
import 'package:fireflow/fireflow.dart';

// Get document (Not reference) to make it easy on UI builder.
Future chatSendMessage(
  UsersPublicDataRecord? otherUserPublicDataDocument,
  ChatRoomsRecord? chatRoomDocument,
  String? text,
  String? uploadUrl,
) async {
  // Add your function code here!

  // Note, don't wait for the message to be sent. So, it will perform faster.
  return ChatService.instance.sendMessage(
    otherUserDocumentReference: otherUserPublicDataDocument?.reference,
    chatRoomDocumentReference: chatRoomDocument?.reference,
    text: text,
    uploadUrl: uploadUrl,
  );
}
```

### How to update chat message

When a user updates a message, simply call the `ChatService.instance.updateMessage()` method.
You can create a custom action `onChatMessageUpdate` that wraps the `ChatService.instance.updateMessage()` method.

```dart
import 'package:fireflow/fireflow.dart';

// Get document (Not reference) to make it easy on UI builder.
Future chatSendMessage(
  UsersPublicDataRecord? otherUserPublicDataDocument,
  ChatRoomsRecord? chatRoomDocument,
  String? text,
  String? uploadUrl,
) async {
  // Add your function code here!

  // Note, don't wait for the message to be sent. So, it will perform faster.
  return ChatService.instance.sendMessage(
    otherUserDocumentReference: otherUserPublicDataDocument?.reference,
    chatRoomDocumentReference: chatRoomDocument?.reference,
    text: text,
    uploadUrl: uploadUrl,
  );
}
```






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




## Chat message count

- Fireflow counts the no of chat message that a user sent. The count increases on every minutes. It's 60 seconds by default. You can change it in config.dart
  - For instance, when the user sends a message for the first after app boots, it will not count. After the first message, it will count after a minutes if the user chats again. and from there it will count on every minutes. It will only increase by 1 even if the user sends chat messages more than 1 in a minute.

- The no of count is saved in `/users_public_data/<uid> { chatMessageCount: xx }`.
- You can use it for leveling user's activity or whatever.

