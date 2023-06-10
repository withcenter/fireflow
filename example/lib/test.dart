// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:example/firebase_options.dart';
import 'package:example/key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Supabase.initialize(
    url: 'https://crhqrbyjksnyqdrpqedr.supabase.co',
    anonKey: supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      AppService.instance.init(
        context: context,
        debug: true,
        noOfRecentPosts: 4,
        supabase: SupabaseOptions(
          usersPublicData: 'users_public_data',
          posts: 'posts',
          comments: 'comments',
          postsAndComments: 'posts_and_comments',
          search: 'search',
        ),
        messaging: MessagingOptions(
          foreground: false,
          background: false,
          onTap: (String initialPageName, Map<String, String> parameterData) {
            dog('on message tap: $initialPageName, Map<String, String> $parameterData');
            AppService.instance.context
                .pushNamed(initialPageName, queryParams: parameterData);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: null,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // TestService.instance.run();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: TestService.instance.prepare,
              child: const Text('Prepare'),
            ),
            ElevatedButton(
              onPressed: TestService.instance.run,
              child: const Text('Run'),
            ),
            ElevatedButton(
              onPressed: TestService.instance.follow,
              child: const Text('Test Follow'),
            ),
            ElevatedButton(
              onPressed: TestService.instance.feeds,
              child: const Text('Test Feeds'),
            ),
            // ElevatedButton(
            //   onPressed: TestService.instance.supabaseSearch,
            //   child: const Text('Test Supbase Search'),
            // ),
          ],
        ),
      ),
    );
  }
}
