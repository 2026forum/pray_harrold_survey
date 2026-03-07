import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/ui/post_subject_screen.dart';
import 'package:pray_harrold_survey/ui/subject_detail_screen.dart';

import 'models/subject.dart';

class GoTo {
  static postSubject(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostSubjectScreen()));
  }

  static subjectDetail(BuildContext context, Subject subject){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubjectDetailScreen(subject)));
  }
}
