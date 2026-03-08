import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalOptionsScreen extends ConsumerStatefulWidget {
  const PersonalOptionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalOptionsScreenState();
}

class _PersonalOptionsScreenState extends ConsumerState<PersonalOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true, title: const Text("COMING SOON")),body: Center(child: Text("USERNAME CHANGE AND MORE"),),);
  }
}
