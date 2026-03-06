import 'package:flutter/material.dart';

//app bar text
const kTitleText = "Uh Oh!";
//center text
const kText = "Must Be On Campus To Participate.";

class ImproperlyLocatedScreen extends StatelessWidget {
  const ImproperlyLocatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kTitleText)),
      body: Center(child: Text(kText)),
    );
  }
}
