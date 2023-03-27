import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({
    super.key,
    this.categoryId,
    required this.onCreated,
  });

  final String? categoryId;
  final void Function(PostModel) onCreated;

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  String? selectedCategoryId;
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final List<String> files = [];

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: CategoryService.instance.displayCategoryInForm.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              dog(snapshot.error.toString());
              return Center(
                child: Text('Error ${snapshot.error}}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.size == 0) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return DropdownMenu<String>(
              initialSelection: selectedCategoryId,
              dropdownMenuEntries: snapshot.data!.docs
                  .map((e) => CategoryModel.fromSnapshot(e))
                  .map((e) => DropdownMenuEntry<String>(
                        value: e.id,
                        label: e.title,
                      ))
                  .toList(),
              onSelected: (value) => setState(
                () {
                  selectedCategoryId = value;
                },
              ),
            );
          },
        ),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Title',
          ),
        ),
        TextField(
          controller: contentController,
          decoration: const InputDecoration(
            hintText: 'Content',
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () async {
                  final uploadedUrls =
                      await StorageService.instance.uploadMedia(
                    context: context,
                    allowPhoto: true,
                    allowAnyfile: true,
                    allowVideo: true,
                    multiImage: false,
                    maxHeight: 1024,
                    maxWidth: 1024,
                    imageQuality: 80,
                  );
                  setState(() {
                    files.addAll(uploadedUrls);
                  });
                },
                icon: const Icon(Icons.camera_alt)),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (selectedCategoryId == null) {
                  warning(context, 'Please select category');
                  return;
                }

                final post = await PostService.instance.create(
                  title: titleController.text,
                  content: contentController.text,
                  categoryId: selectedCategoryId!,
                  files: files,
                );
                widget.onCreated(post);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: files.map((url) {
              return Stack(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(url),
                  ),
                  IconButton(
                    onPressed: () async {
                      await StorageService.instance.delete(url);
                      files.remove(url);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
