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


