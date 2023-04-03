# Files

## Storage Files Schema

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-schema-storage-files.jpg?raw=true "Flutterflow storage_files schema")

 - `userDocumentReferences` is the uploader document reference.
 - `uid` it was the uploader uid.
 - `createdAt` is the timestamp it was created.
 - `contentType` is the mime type.
 - `size` is the file size.
 - `url` is the file url.
 - `fullPath` is the file full path.
 - `name` is the file name.
 - `type` is the file type base on contentType. If the `contentType` is `aplication/...`, then it will take the type of the file like `zip`, `pdf`, etc.
  
## Overview of file management

- If you(as an admin of your app) could see what files are uploaded, It would be helpful to manage.
- It would be helplful if you can
  - list images and videos to see if there are any malicious photos, videos.
  - list by size, file type, users.

- It is recommended to update the storage files list on desktop(or laptop) computer since it consumes more resouces.


## Logic of File management

Updating storage files

- Create Custom Action  
- Add fireflow as dependencies
- Add the following code

```dart
import 'package:fireflow/fireflow.dart';

Future updateStorageFiles() async {
  return StorageService.instance.updateStorageFiles();
}
```

- `StorageService.instance.updateStorageFiles()` will get all the files and store them into `/storage_files`.
  - See [Storage - List all files](https://firebase.google.com/docs/storage/flutter/list-files#list_all_files) and [Firestore - Batch Write](https://firebase.google.com/docs/firestore/manage-data/transactions#batched-writes).
  - Since it may consume some resources, it is a good idea to display a confirm dialog to update the list when the admin enters the page.
  - That's it. You can customize from here for your projects. See the `Customizing File Management`.

### Triggering UpdateStorageFiles


- Add page parameter named `firstEntry` with type `boolean` and set default value to `false`.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-first-entry.jpg?raw=true "Flutterflow storage_files firstEntry parameters")

- Select the base page in widget tree in the example it is named `AdminStorageFiles`, in the scaffold settings click `Actions` and click `Open` to open the action flow editor.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-on-page-load-click.jpg?raw=true "Flutterflow storage_files navigate on page load")

- Add `Condition` action and choose the `firstEntry` from parameters as conditional value.
- If `true`, Show an `Alert Dialog`(Confirm Dialog) asking if you want to update the Storage Files Information.
- If `true`, Call the custom action `updateStorageFiles` that we added. and show `alert dialog` that it was done updating.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-on-page-load.jpg?raw=true "Flutterflow storage_files confirmation action chain")

- To trigger the action we just need to define an action `Navigate to` page `Admin Storage Files`
- Pass the `firstEntry` parameter and set its value to `true`.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-navigate.jpg?raw=true "Flutterflow storage_files page navigate")

- When the page is loaded a Confirm Dialog should appear. Confirming if you want to update the current StorageFiles Information
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-confirm-dialog.jpg?raw=true "Flutterflow storage_files page navigate")

- Once done it should display another Alert Dialog displaying that the changes are now updated.
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-success.jpg?raw=true "Flutterflow storage_files page navigate")


- Alternatively you can also add a `Button Widget` to trigger the same `action chain` without the `Condition` action for `firstEntry`. 
- Starting with the `Alert Dialog`(Confirm Dialog) to confirm if you want to update the storageFiles information.
- If `true`, call the custom action `updateStorageFiles` to update the `storageFiles` Information and show `Alert dialog` to confirm the changes.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-update-from-button-click.jpg?raw=true "Flutterflow storage_files update from button click")



## Customizing File Management

- Once you update(sync) the storage files into `/storage_files`, you have all the list of uploaded files with the fields of `url, uid, name, full path, size, contentType, type, createdAt`.
  - `type` is coming from the `contentType`.
    - It can be `image`, `video`, `audio`, `text`, etc.
    - If the `contentType` is `aplication/...`, then it will take the type of the file like `zip`, `pdf`, etc.
- You can search the `url` in firestore to know which document that it is attached to.

### Simple File Listing
- Add a `ListView Widget` to our page and add a Query.
- Select `Query Collection` from query type.
- Select `storage_files` from collection.
- Select `List of Documents` from return type.
- Optionally you can turn on `Enable Infinite Scroll` and add `Page Size`.
  
  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-simple-query.jpg?raw=true "Flutterflow storage_files simple query")

- Under the `ListView`
- We will add the [DisplayMedia widget](#displaymedia-widget) to show a preview of our file.
- Set the width and height
- Pass the file url to DisplayMedia Widget

  ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-simple-page.jpg?raw=true "Flutterflow storage_files simple page")

### File Listing with Filters and Order

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-storage-files-search-options.jpg?raw=true "Flutterflow storage_files search options")

Search Options

- We will search with the following filters

  - `userDocumentReference` filter user who upload the file
  - `type` filter by specific type
  - `createdAt` order by date and filtering with date
  - `size` order by size
  
  Since we are using firebase as our database we cant OrderBy the `createdAt` and `size` at the same time as it return undesirable results. What we will do is we will have different query filters to support order by `createdAt` and `size`. 


- To get `userDocumentReference`
  - Add a IconButton
  - Add an Action to show a buttomSheet and search for user
- Dropdown button with the list of `filetype`
- Dropdown button with list of possible Orderby
  
- DateRange Selection
  - `beginDate` DatePicker
  - `endDate` DatePicker
  
- Submit Button


Query Filter sample

- userDocumentReference, type, dateRange, CreatedAt Desc
- userDocumentReference, type, dateRange, CreatedAt Asc

- userDocumentReference, type, Size Desc
- userDocumentReference, type, Size Asc
















