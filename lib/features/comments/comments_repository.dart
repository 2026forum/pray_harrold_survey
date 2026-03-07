import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../models/comment.dart';
import '../../util/firebase/firebase_providers.dart';
import '../../util/type_defs.dart';

final commentsFeedProvider = StreamProvider.autoDispose.family<List<Comment>, String>((ref, String issueId) {
  final commentsRepository = ref.read(commentsRepositoryProvider(issueId));
  return commentsRepository.commentsStream();
});

final commentsRepositoryProvider = Provider.autoDispose.family<CommentsRepository, String>((ref, String subjectId) {
  final firestore = ref.read(firestoreProvider);
  return CommentsRepository(firestore: firestore, subjectId: subjectId);
});

class CommentsRepository {
  final FirebaseFirestore _firestore;
  final String _subjectId;

  CommentsRepository({required FirebaseFirestore firestore, required String subjectId}) : _firestore = firestore, _subjectId = subjectId;

  CollectionReference get _subjectComments => _firestore.collection('subjects').doc(_subjectId).collection('comments');

  Stream<List<Comment>> commentsStream() {
    return _subjectComments.snapshots().map((event) => event.docs.map((e) => Comment.fromMap(e.data() as Map<String, dynamic>)).toList());
  }






  

  FutureEitherFailureOr<void> addComment(Comment comment, String userId) async {
    try {
      return right(_subjectComments.doc(userId).set(comment.toMap()));
    } on FirebaseException {
      return left(Failure('something went wrong(firebase exception)'));
    } catch (e) {
      return left(Failure('something went wrong'));
    }
  }
}
