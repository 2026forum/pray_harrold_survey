import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/models/assessment.dart';
import 'package:pray_harrold_survey/ui/menu_pages/contact_me_screen.dart';
import 'package:pray_harrold_survey/ui/post_subject_screen.dart';
import 'package:pray_harrold_survey/ui/subject_detail_screen.dart';

import 'models/subject.dart';

class GoTo {


  static postSubject(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostSubjectScreen()));
  }

  static subjectDetail(BuildContext context, Subject subject, Assessment assessment){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubjectDetailScreen(subject, assessment)));
  }

  static contact(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContactMeScreen()));
  }
}
