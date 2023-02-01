


# Development tips

## Safe string

- In some cases the string should be in a moderate format. Like when the post content is delivered over push notification, it should not be too long and should not contain any special characters, nor HTML tags.
- To use the user input value over those cases, fireflow uses the [`safeString` function](https://pub.dev/documentation/fireflow/latest/fireflow/safeString.html).
