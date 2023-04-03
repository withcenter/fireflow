
# User

## users schema


Schema **users**

| Field Name | Data Type |
|------------|----------:|
| email | String |
| display_name | String |
| photo_url | Image Path |
| uid | String |
| created_time | Timestamp |
| phone_number | String |
| name | String |
| admin | Boolean |
| blockedUsers | List < Doc Reference (users) > |
| isProfileComplete | Boolean |
| favoriteChatRoomDocumentReferences | List < Doc Reference (chat_rooms) > |
| userDocumentReference | Doc Reference (users) |
| updatedAt | Timestamp |
| coverPhotoUrl | ImagePath |
| gender | String |
| birthday | Timestamp |
| hasPhoto | Boolean |
| lastPostCreatedAt | Timestamp |
| lastPost | Data (recentPosts) |
| recentPosts | List < Data ( recentPosts) > |
| isPremiumUser | Boolean |
| noOfPosts | Integer |
| noOfComments | Integer |
| followings | List < Doc Reference (users) > |
| referral | Doc Reference (users) |
| referralAcceptedAt | Timestamp |
| chatMessageCount | Integer |
| stateMessage | String |





- Add `userPublicDataDocumentReference` to `users` schema. This is the connection to `users_public_data` schema.

- Add `admin` boolean. If this is set to true, the user will see admin menu. To give the user admin permission, you need to add the uid of the user into the system_settings collection.

- `name` is for user's full name. You may use it for other purpose.

- `isProfileComplete` is set to `true` if the user filled in the necessary fields in his profile. Or false.
  - This field is updated when user updates his profile.
  - As of now, the user must filled his display name and photo url.
  - Note that, this field should be in `users` collection for easy access.


- `favoriteChatRoomDocumentReferences` is the list of the favorite chat room of the user.


- Create the [`recentPosts` data type](https://github.com/withcenter/fireflow/blob/main/etc/readme/flutterflow/en/forum.md) first, then `users_public_data` schema in Flutterflow like below.

- Note that, you can add more fields if you want.



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
- `isProfileComplete` is set to true when the user completed his profile information.
- `coverPhotoUrl` is the url of the cover photo of the user.
- `recentPosts` is the list of the last recent posts that the user created. Note that, to create the `recentPosts` field in `posts` collection, you will need to create the `recentPosts` Data Type first.
- `lastPostCreatedAt` is the time that the user created the last post.
- `isPremiumUser` is set to `true` if the user is paid for premium service.
- `referral` is the user document reference who invited me.
- `referralAcceptedAt` is the time that he user accepted(registered) the invitation.
- `stateMessage` is the user's state message. It can be used to display the user's mood or motto. It's a shout-out.

- `chatMessageMinuteCount` is the no of minutes that the user sent. See No of chat message in chat.md




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


