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

  Future<void> postSubject(String title, BuildContext context) async {
    state = true;
    final subjectsRepository = ref.read(subjectsRepositoryProvider);
    final userId = ref.read(personProvider)!.uid; 
    final newId = const Uuid().v1();
    final newSubject = Subject(subjectId: newId, title: title, agreement: [userId], disagreement: []);
    final result = await subjectsRepository.postSubject(newSubject);
    state = false;
    result.fold((l) => showSnackyBar(context, l.message), (r) => showSnackyBar(context, 'Thank You!'));
  }
}
