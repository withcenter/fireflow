import 'dart:io';

import 'package:example/firebase_options.dart';
import 'package:example/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Supabase.initialize(
    url: 'https://crhqrbyjksnyqdrpqedr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNyaHFyYnlqa3NueXFkcnBxZWRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzQxODg0NDksImV4cCI6MTk4OTc2NDQ0OX0.r1Ke5LhgAYDDgBwH_4zJJaqWr_txUPWQGh3bCoIh8is',
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

    /// AppService 초기화
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      AppService.instance.init(
        context: context,
        debug: true,
        supabase: true,
        tables: SupabaseTables(
          usersPublicData: 'users_public_data',
          posts: 'posts',
          comments: 'comments',
        ),
      );
    });

    /// 푸시 알림 토큰 업데이트
    FirebaseAuth.instance.authStateChanges().where((user) => user != null).map((user) => user!.uid).distinct().listen((event) async {
      if (kIsWeb) return;
      MessagingService.instance.updateToken(await FirebaseMessaging.instance.getToken());
      FirebaseMessaging.instance.onTokenRefresh.listen(MessagingService.instance.updateToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
