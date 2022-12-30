import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/scheduler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      AppService.instance.init(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '1 + 1 = ${Calculator().addOne(1)}',
            ),
            // ElevatedButton(
            //     onPressed: () => AppService.instance.addOne(5),
            //     child: const Text('Add 1 on 5')),
          ],
        ),
      ),
    );
  }
}
