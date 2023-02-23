import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.pushNamed('Calendar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        color: Colors.pink.shade50,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                children: [
                  Text("Language code: ${Localizations.localeOf(context).languageCode}, "),
                  Text("home: ${TranslationService.instance.get('home')}"),
                ],
              ),
              Text('TODO: User registration and profile update.\nTODO: file upload on forum '),
              ElevatedButton(
                  onPressed: () =>

                      /// throw an exception
                      throw Exception('Test Exception'),
                  child: const Text('Exception')),
              if (UserService.instance.isLoggedIn)
                Wrap(
                  children: [
                    MyDoc(builder: (my) => Text(my.displayName)),
                    Text(UserService.instance.uid),
                  ],
                ),
              const SizedBox(
                height: 24,
              ),
              const Text('Home'),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () => context.pushNamed('CustomPopup'),
                child: const Text('Custom Popup'),
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () => context.pushNamed('Register'),
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.pushNamed('Login'),
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Log-Out'),
                  ),
                ],
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () => context.pushNamed('AdminTranslation'),
                    child: const Text('Language Settings'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.pushNamed('CategoryList'),
                    child: const Text('Category List'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.pushNamed('Setting'),
                    child: const Text('Settings'),
                  ),
                ],
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () => context.pushNamed('Calendar'),
                    child: const Text('Calendar'),
                  ),
                ],
              ),
              StreamBuilder(
                stream: CategoryService.instance.col.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final category = CategoryModel.fromSnapshot(snapshot.data!.docs[index]);
                        return ListTile(
                          title: Text(category.title),
                          subtitle: Text('category: ${category.category}'),
                          onTap: () => context.pushNamed(
                            'PostList',
                            queryParams: {
                              'category': category.category,
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              ElevatedButton(
                onPressed: () => StorageService.instance.updateStorageFiles(),
                child: const Text('Update file list'),
              ),
              ElevatedButton(
                onPressed: () => StorageService.instance.deleteStorageFiles(),
                child: const Text('Delete all files on storage'),
              ),
              // ElevatedButton(
              //   onPressed: () =>
              //       snackBarSuccess(title: 'title', message: 'message'),
              //   child: const Text('snackbar'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
