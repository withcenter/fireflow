import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
        ),
        body: Column(
          children: [
            SwitchListTile(
                title: const Text('Notify new comments'),
                value: true,
                onChanged: (value) {
                  UserSettingService.instance.notifyNewComments(value);
                }),
          ],
        ));
  }
}
