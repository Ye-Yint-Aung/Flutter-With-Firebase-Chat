import 'package:flutter/material.dart';

class HelloTest extends StatefulWidget {
  const HelloTest({super.key});

  @override
  State<HelloTest> createState() => _HelloTestState();
}

class _HelloTestState extends State<HelloTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 2000,
            child: ListView(
              children: [
                const Text("A"),
                const Text("B"),
                Row(
                  children: [Text("Hello")],
                )
              ],
            ),
          ),
          const Center(
            child: Text("Hello"),
          ),
        ],
      ),
    );
  }
}
