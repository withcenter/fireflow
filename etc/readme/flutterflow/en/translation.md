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

- The fireflow provides a ready-to-use wigdet that you can easily apply to your project.
  With the `Translate` widget, you can
  - add
  - search
  - delete
  the translations.

- To apply,
  - Create a widget named `AdminTranslation` with no parameter. But you need the `fireflow` as dependency.
  - And use it in your screen.

```dart
import 'package:fireflow/fireflow.dart';

class AdminTranslation extends StatefulWidget {
  const AdminTranslation({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _AdminTranslationState createState() => _AdminTranslationState();
}

class _AdminTranslationState extends State<AdminTranslation> {
  @override
  Widget build(BuildContext context) {
    return Translation(
      languages: ['en', 'ko'],
    );
  }
}
```



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


