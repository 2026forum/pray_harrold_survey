import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/subject.dart';

class SubjectDetailScreen extends ConsumerStatefulWidget {
  final Subject subject;
  const SubjectDetailScreen(this.subject, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.subject.title)));
  }
}
