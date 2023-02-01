

# Actions


## snackBarSuccess

The snackbar in the flutterflow is okay. But I want to have my own design of snackbars. So, here are the two. It's relatively easy to apply the snackbar.

Example custom action code for applying fireflow snackbar.
```dart
import 'package:fireflow/fireflow.dart';

Future snackBar(
  BuildContext context,
  String title,
  String message,
) async {
  // Add your function code here!
  snackBarSuccess(context: context, title: title, message: message);
}
```

The snackbar applied to the app.
![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-1.jpg?raw=true "Snackbar")


Add snackBarSuccess Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-2.jpg?raw=true "Snackbar")

## snackBarWarning

Add snackBarWarning Custom Action like below.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/snackbar-3.jpg?raw=true "Snackbar")
