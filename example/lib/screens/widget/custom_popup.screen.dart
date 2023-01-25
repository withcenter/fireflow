// ignore_for_file: sized_box_for_whitespace

import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CustomPopupScreen extends StatelessWidget {
  const CustomPopupScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Popup"),
        actions: [
          CustomPopup(
            dx: 0,
            dy: 32,
            popup: Container(
              padding: const EdgeInsets.all(24),
              color: Colors.amber,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Custom Popup'),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Content of the popup, long before'),
                  const Text(
                      'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                  const Text('Content of the popup, long before'),
                  const Text(
                      'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                  TextButton.icon(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.close),
                    label: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.settings)),
          ),
        ],
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('Custom Popup'),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.topLeft,
                child: CustomPopup(
                  dx: 2560,
                  popup: Container(
                    color: Colors.blue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Custom Popup'),
                        const Text('Content of the popup, long before'),
                        const Text(
                            'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                        const Text('Content of the popup, long before'),
                        const Text(
                            'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                        TextButton.icon(
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(Icons.close),
                          label: const Text(
                            'Close',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    color: Colors.lightBlue,
                    child: const Text('Tap to show custom popup'),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              const Text('Anonother Custom Popup'),
              const SizedBox(height: 10),
              CustomPopup(
                dy: 16,
                dx: -256,
                popup: Container(
                  color: Colors.amber,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Custom Popup'),
                      Text('Content of the popup, long before'),
                      Text(
                          'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                      Text('Content of the popup, long before'),
                      Text(
                          'Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                    ],
                  ),
                ),
                child: Container(
                  color: Colors.lightBlue,
                  child: const Text('Tap to show custom popup'),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 500),
              const Text('I dont wan t'),
              const SizedBox(height: 210),
            ],
          ),
        ),
      ),
    );
  }
}
