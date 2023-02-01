# Text translation support

- Why do we need another text translation support while flutterflow has one?
  - That is because we cannot translate a text that is dynamically generated and the fireflow displays somet text depending on its usage and it needs a way to show in the user's language.
- It is working by default whether the app uses it or not.
- To use the translation,
  - You can simply add translation data into the firestore.
  - Or you can use `Translation` widget to update the translation.
    - Only admin can create or delete.

## Putting translations directly into the Firestore

- Open Firebase console -> Firestore Database.
- Create a document `/system_settings/translations`.
- Add a document with
  - `Camera` as the key
  - `{ en: Camera, ko: 카메라 }` as the value in map.

Below is the example screen.
![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/firestore-translation.jpg?raw=true "Translation")



## Translate widget

- With `Translate` widget, you can
  - add
  - search
  - delete
  the translations.


## List of translations


- Below are the necessary translation codes for media upload.
  - `Choose Source`
  - `Gallery (Photo)`
  - `Gallery (Video)`
  - `Gallery`
  - `Camera`
  - `Upload Any File`
  - `Success to upload media`
  - `Failed to upload media`


