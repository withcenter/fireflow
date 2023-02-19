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

## Indexing error

For `feeds` function to work, you will need to create an index by clicking the url in the web browser console.

```txt
Uncaught (in promise) Error: [cloud_firestore/failed-precondition] The query requires an index. You can create it here: https://console.firebase.google.com/v1/r/project/phiter/firestore/indexes?create_composite=Cltwcm9qZWmZXJlbmNlEAEaFQoRbGFzdFBvc3RDcmVhdGVkQXQQAhoMCghfX25hbWVfXxAC
```



## CORS problem

If you see a CORS error on the console log in developer console, it means the client(your app) is not allowed to access the site. This may happens on URL preview. It really depends on each website. Some websites allow access to all clients while some other websites are not.

```txt
Access to XMLHttpRequest at 'https://yahoo.com/' from origin 'https://ff-debug-service-frontend-ygxkweukma-uc.a.run.app' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```