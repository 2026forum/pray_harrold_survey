import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';

import '../../models/comment.dart';
import '../../models/subject.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  final Subject subject;
  const CommentTile(this.comment, this.subject, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final person = ref.watch(personProvider)!;
    final personAgrees = subject.agreement.contains(comment.authorId);
    final personDisagrees = subject.disagreement.contains(comment.authorId);
    return ListTile(
      title: Center(child: Text('"${comment.commentText}"')),
      subtitle: Center(child: Text("- ${comment.author}")),
      tileColor: personAgrees
          ? person.shadedProColor
          : personDisagrees
          ? person.shadedConColor
          : null,
    );
  }
}
