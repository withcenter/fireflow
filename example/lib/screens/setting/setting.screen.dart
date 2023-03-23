import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

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
          StreamBuilder(
            stream: UserSettingService.instance.ref.snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.exists == false) {
                return const Center(child: CircularProgressIndicator());
              }

              final settings = UserSettingModel.fromSnapshot(snapshot.data!);

              return SwitchListTile(
                title: const Text('Notify new comments'),
                value: settings.notifyNewComments,
                onChanged: (value) {
                  UserSettingService.instance.notifyNewComments(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
