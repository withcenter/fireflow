# Trouble Shotting

## Analyzing error

If you see a message like `isn't defined` in the error like below, it would probably not use the latest version of fireflow.

```txt
The named parameter 'context' isn't defined.
Try correcting the name to an existing named parameter's name, or defining a named parameter with the name 'context'.dartundefined_named_parameter
```

You need to put a version in package dependency like `fireflow: ^0.1.23`.

## Error running "flutter pub get"

When you see this error message, there is a problem while `flutter pub get`. This happens when you add a package that has conflict on other packages. Ask it to fireflow developer.

Note that, as of Feb 1st, 2023, You need to enable Supabase even if you don't use it.
