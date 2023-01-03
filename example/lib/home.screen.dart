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

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   AppService.instance.init(context: context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PopupMenuButton(
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        child: Text('Item 1'),
                      ),
                      PopupMenuItem(
                        child: Text('Item 2'),
                      ),
                      PopupMenuItem(
                        child: Text('Item 3'),
                      ),
                    ]),
              ),
              ElevatedButton(
                  onPressed: () {
                    final renderBox = context.findRenderObject() as RenderBox;
                    final size = renderBox.size;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    showGeneralDialog(
                      context: context,
                      barrierColor: Colors.black54,
                      barrierDismissible: true,
                      barrierLabel: 'Label',
                      pageBuilder: (context, __, ___) {
                        return Stack(
                          children: [
                            Positioned(
                              top: offset.dy,
                              left: offset.dx,
                              child: Container(
                                color: Colors.blue,
                                child: Column(
                                  children: [
                                    Text('Popup'),
                                    FlutterLogo(size: 150),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Show Dialog')),
              const SizedBox(height: 100),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 100),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 100),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.topLeft,
                child: CustomPopup(
                  popup: Container(
                    color: Colors.blue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Custom Popup'),
                        Text('Content of the popup, long before'),
                        Text('Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                        Text('Content of the popup, long before'),
                        Text('Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                        TextButton.icon(
                          onPressed: Navigator.of(context).pop,
                          icon: Icon(Icons.close),
                          label: Text(
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
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              CustomPopup(
                dy: 64,
                popup: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Custom Popup'),
                      Text('Content of the popup, long before'),
                      Text('Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                      Text('Content of the popup, long before'),
                      Text('Apple, Banana, Cherry, Durian, Eggplant, Fig, Grape'),
                    ],
                  ),
                ),
                child: Container(
                  color: Colors.lightBlue,
                  child: const Text('Tap to show custom popup'),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.close),
                  label: const Text('Hide Custom Popup')),
              PopupMenuButton(
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        child: Text('Item 1'),
                      ),
                      PopupMenuItem(
                        child: Text('Item 2'),
                      ),
                      PopupMenuItem(
                        child: Text('Item 3'),
                      ),
                    ]),
              ),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 100),
              const SizedBox(height: 100),
              const Text('Hi, there. How are you?'),
              const SizedBox(height: 100),
              const SizedBox(height: 210),
              const Text('Hi, there. How are you?'),
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
