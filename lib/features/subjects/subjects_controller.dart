import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_repository.dart';
import 'package:pray_harrold_survey/models/subject.dart';
import 'package:pray_harrold_survey/util/show_messages.dart';
import 'package:uuid/uuid.dart';



final subjectsControllerProvider = NotifierProvider.autoDispose<SubjectsController, bool>(SubjectsController.new);

class SubjectsController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  SubjectsRepository get _subjectsRepository => ref.read(subjectsRepositoryProvider);
  String? get _userId => ref.read(personProvider)?.uid;

  Future<void> postSubject(String title, BuildContext context) async {
    state = true;

    final newId = const Uuid().v1();
    final newSubject = Subject(subjectId: newId, title: title, agreement: [?_userId], disagreement: []);
    final result = await _subjectsRepository.postSubject(newSubject);
    state = false;
    result.fold((l) => showSnackyBar(context, l.message), (r) => showSnackyBar(context, 'Thank You!'));
  }
}
