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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        color: Colors.pink.shade50,
        child: Column(
          children: [
            if (UserService.instance.isLoggedIn) Text(UserService.instance.uid),
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
            ElevatedButton(
              onPressed: () => context.pushNamed('CategoryList'),
              child: const Text('Category List'),
            ),
            ElevatedButton(
              onPressed: () => context.pushNamed('Setting'),
              child: const Text('Settings'),
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
          ],
        ),
      ),
    );
  }
}
