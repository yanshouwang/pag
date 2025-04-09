import 'package:flutter/material.dart';

import 'package:pag_flutter/pag_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final PAGController controller;

  @override
  void initState() {
    super.initState();
    controller = PAGController()..play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PAG')),
        body: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: PAGView.asset(
                      'assets/scan.pag',
                      controller: controller,
                      repeatCount: 0,
                      scaleMode: PAGScaleMode.letterBox,
                      progress: 0.0,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
