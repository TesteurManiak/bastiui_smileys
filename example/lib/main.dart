import 'package:flutter/material.dart';
import 'package:smiley_ui/smiley_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SmileysSelection(),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => showSmileysBottomSheet(context),
              child: const Text('Show bottom sheet'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => showSmileysDialog(context),
              child: const Text('Show dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
