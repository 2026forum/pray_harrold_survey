import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/comments/comments_repository.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';
import 'package:pray_harrold_survey/ui/widgets/comment_tile.dart';
import 'package:pray_harrold_survey/util/error_loader.dart';

import '../models/subject.dart';

const kComment = "comment";
const kUndoVote = "Rescind Judgement";

const kCommentsHeading = "Here's what they are saying";

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(kCommentsHeading),
            const Divider(),
            Expanded(
              child: ref
                  .watch(commentsFeedProvider(widget.subject.subjectId))
                  .when(
                    data: (commentList) {
                      return ListView.builder(
                        itemCount: commentList.length,
                        itemBuilder: (context, index) {
                          final comment = commentList[index];
                          return CommentTile(comment, widget.subject);
                        },
                      );
                    },
                    error: (error, stackTrace) => ErrorText(error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
