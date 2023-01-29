import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Snackbar action test', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                snackBarSuccess(context: context, title: 'Hello,', message: 'How are you?');
              },
              child: const Text('snackbar'),
            );
          }),
        ),
      ),
    );

    expect(find.textContaining('snackbar'), findsOneWidget);
    await tester.tap(find.textContaining('snackbar'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Hello,'), findsOneWidget);
  });
}
