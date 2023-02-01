# User setting

- User settigns are kept in `/user_settings/<uid>` document.
  - It could be saved in `/users_public_data/<uid>` collection. But the problem is when the client lists/searches user information based on the settings, the firestore downloads the whole document whether is it big or small. And this leads the waste of network bandwidth, time consuming and lagging on the app. And even worse it costs more.

- You just set the settings. That's it. It will work.

## user_settings schema

Schema **user_settings**

| Field Name | Data Type |
|------------|----------:|
| userDocumentReference | Doc Reference (users) |
| type | String |
| action | String |
| category | String |
| notifyNewComments | Boolean |
| postSubscriptions | List < Doc Reference (categories) > |
| commentSubscriptions | List < Doc Reference (categories) > |


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

