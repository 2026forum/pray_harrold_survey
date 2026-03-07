import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/comments/comments_controller.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';
import 'package:pray_harrold_survey/models/assessment.dart';
import 'package:pray_harrold_survey/util/text_validation.dart';

import '../../constants.dart';
import '../../models/subject.dart';
import '../../navigation.dart';

const kPopupCommentAsk = "Why do you feel this way?";

class SubjectTile extends ConsumerWidget {
  final Subject subject;
  final TextEditingController commentController;
  const SubjectTile(this.subject, this.commentController, {super.key});

  // _askForComment(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text(kPopupCommentAsk),
  //             TextField(controller: commentController),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 ElevatedButton(onPressed: () {}, child: const Text('skip')),
  //                 ElevatedButton(onPressed: () {}, child: const Text('ok')),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Future<bool?> _askForComment(BuildContext context) async {
    bool? commenting;
    await showDialog<bool?>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("(optional)"),
                const Text(kPopupCommentAsk),
                TextField(maxLines: 3, maxLength: kCommentMaxChar, controller: commentController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        commenting = true;
                        Navigator.pop(context);
                      },
                      child: const Text('comment'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        commenting = false;
                        Navigator.pop(context);
                      },
                      child: const Text('skip'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return commenting;
  }

  Widget _voteIcon(BuildContext context, WidgetRef ref, bool isUpvote) {
    if (isUpvote) {
      return IconButton(
        onPressed: () {
          _askForComment(context).then((value) {
            if (value == null) {
              return;
            } else if (value && isValidTextValue(commentController)) {
              ref.read(commentsControllerProvider(subject.subjectId)).addComment(commentController.text);
            }

            ref.read(subjectsControllerProvider.notifier).agree(subject.subjectId);
          });
          commentController.clear();
        },
        icon: const Icon(Icons.arrow_upward),
      );
    } else {
      return IconButton(
        onPressed: () {
          _askForComment(context).then((value) {
            if (value == null) {
              return;
            } else if (value && isValidTextValue(commentController)) {
              ref.read(commentsControllerProvider(subject.subjectId)).addComment(commentController.text);
            }
            ref.read(subjectsControllerProvider.notifier).disagree(subject.subjectId);
          });
          commentController.clear();
        },
        icon: const Icon(Icons.arrow_downward),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final person = ref.watch(personProvider)!;
    final userAgrees = subject.agreement.contains(person.uid);
    final userDisagrees = subject.disagreement.contains(person.uid);
    final noJudgementRendered = (!userAgrees && !userDisagrees);
    return ListTile(
      title: Center(child: Text(subject.title)),
      leading: noJudgementRendered ? _voteIcon(context, ref, true) : null,
      trailing: noJudgementRendered ? _voteIcon(context, ref, false) : null,
      tileColor: userAgrees
          ? person.shadedProColor
          : userDisagrees
          ? person.shadedConColor
          : null,
      onTap: () => GoTo.subjectDetail(context, subject, userAgrees ? Assessment.agrees : userDisagrees ? Assessment.disagrees : Assessment.neutral),
    );
  }
}
