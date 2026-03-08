import 'package:flutter/material.dart';

class ThoughtsScreen extends StatelessWidget {
  const ThoughtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Something about having an apolitical appeal..."), Text('This is supposed to be info for the testing team. ')],
          ),
        ),
      ),
    );
  }
}
