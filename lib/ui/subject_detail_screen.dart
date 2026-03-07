import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';

import '../models/subject.dart';

const kComment = "comment";
const kUndoVote = "Rescind Judgement";

class SubjectDetailScreen extends ConsumerStatefulWidget {
  final Subject subject;
  const SubjectDetailScreen(this.subject, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "comment") {}
              if (value == "undoVote") {
                if (widget.subject.agreement.contains(person.uid)) {
                  //TODO make popup
                  ref.read(subjectsControllerProvider.notifier).unAgree(widget.subject.subjectId);
                }
                if (widget.subject.disagreement.contains(person.uid)) {
                  ref.read(subjectsControllerProvider.notifier).unDisagree(widget.subject.subjectId);
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'comment', child: const Text(kComment)),
              PopupMenuItem(value: 'undoVote', child: const Text(kUndoVote)),
            ],
            child: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
