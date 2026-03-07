import 'package:flutter/material.dart';

class ContactMeScreen extends StatelessWidget {
  const ContactMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('contact info')),
      body: Column(children: [const Text('Email:'),
      const SelectableText("jjflowers734@gmail.com")]),
    );
  }
}
