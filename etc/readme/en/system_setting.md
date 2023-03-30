# System setting

Some API Keys like Open AI will be invalid once it is open to the public. So, it needs to be kept in the database (or somewhere else).

In Fireflow, those keys should be in /system_settings/keys { keyName: … }

## System Keys

### Open AI API Key

* Open AI API Key should be saved as below.

```txt
/system_settings/keys {
  openAiApiKey: ...
}
```


* It is loaded automatically by the fireflow and you can use it in your code like below.

```dart
'Authorization': 'Bearer ${AppService.instance.keys.openAiApiKey}',
```

* Or simply do Firestore backend query to get the api key and do query.





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


