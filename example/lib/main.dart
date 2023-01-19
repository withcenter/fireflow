import 'package:example/firebase_options.dart';
import 'package:example/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Supabase.initialize(
    url: 'https://kjlezwfqiitsggumxqyw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtqbGV6d2ZxaWl0c2dndW14cXl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEzNjI2NDksImV4cCI6MTk4NjkzODY0OX0.qnTkAP2qU80WsgBSntsj3g9mAQakbAw07er1hXoJGiI',
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
      AppService.instance.init(context: context, debug: true, supabase: true);
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
