import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';

import '../../models/subject.dart';
import '../../navigation.dart';

class SubjectTile extends ConsumerWidget {
  final Subject subject;
  const SubjectTile(this.subject, {super.key});

  Widget _voteIcon(WidgetRef ref, bool isUpvote) {
    if (isUpvote) {
      return IconButton(
        onPressed: () {
          ref.read(subjectsControllerProvider.notifier).agree(subject.subjectId);
        },
        icon: const Icon(Icons.arrow_upward),
      );
    } else {
      return IconButton(
        onPressed: () {
          ref.read(subjectsControllerProvider.notifier).disagree(subject.subjectId);
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
      leading: noJudgementRendered ? _voteIcon(ref, true) : null,
      trailing: noJudgementRendered ? _voteIcon(ref, false) : null,
      tileColor: userAgrees
          ? person.shadedProColor
          : userDisagrees
          ? person.shadedConColor
          : null,
      onTap: () => GoTo.subjectDetail(context, subject),
    );
  }
}
