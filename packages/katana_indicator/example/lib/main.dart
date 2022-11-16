import 'package:flutter/material.dart';
import 'package:katana_indicator/katana_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ShortenPage(),
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class ShortenPage extends StatelessWidget {
  const ShortenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Demo")),
      body: Container(
        color: Colors.blue,
        child: const ColoredBox(
          color: Colors.red,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Start");
          Future.delayed(const Duration(seconds: 3)).showIndicator(context);
          debugPrint("End");
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
