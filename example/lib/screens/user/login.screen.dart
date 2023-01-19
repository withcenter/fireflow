import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
          child: Column(
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      )),
    );
  }
}
