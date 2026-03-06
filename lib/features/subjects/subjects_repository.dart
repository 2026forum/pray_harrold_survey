import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pray_harrold_survey/models/subject.dart';

import '../../util/firebase/firebase_providers.dart';
import '../../util/type_defs.dart';

final subjectsFeedProvider = StreamProvider.autoDispose<List<Subject>>((ref) {
  final subjectsRepository = ref.watch(subjectsRepositoryProvider);
  return subjectsRepository.subjectFeed;
});

final subjectsRepositoryProvider = Provider<SubjectsRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return SubjectsRepository(firestore: firestore);
});

class SubjectsRepository {
  final FirebaseFirestore _firestore;

  SubjectsRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _subjects => _firestore.collection('subjects');

  Stream<List<Subject>> get subjectFeed =>
      _subjects.snapshots().map((event) => event.docs.map((e) => Subject.fromMap(e.data() as Map<String, dynamic>)).toList());

  FutureEitherFailureOr<void> postSubject(Subject subject) async {
    try {
      return right(_subjects.doc(subject.subjectId).set(subject.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
