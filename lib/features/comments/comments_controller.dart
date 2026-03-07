import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/comments/comments_repository.dart';
import 'package:pray_harrold_survey/models/comment.dart';

import '../../models/person.dart';

final commentsControllerProvider = Provider.autoDispose.family<CommentsController, String>((ref, String subjectId) {
  final commentsRepository = ref.read(commentsRepositoryProvider(subjectId));
  final person = ref.read(personProvider)!;
  return CommentsController(commentsRepository: commentsRepository, person: person);
});

class CommentsController {
  final CommentsRepository _commentsRepository;
  final Person _person;

  CommentsController({required CommentsRepository commentsRepository, required Person person})
    : _commentsRepository = commentsRepository,
      _person = person;

  Future<String> getUserComment() async {
    final comment = await _commentsRepository.getUserComment(_person.uid);
    return comment;
  }

  void addComment(String commentText) async {
    final comment = Comment(commentText: commentText, author: _person.username, authorId: _person.uid);
    final result = await _commentsRepository.addComment(comment, _person.uid);

    result.fold((l) => null, (r) => null);
  }

  deleteComment() => _commentsRepository.deleteComment(_person.uid);
}
