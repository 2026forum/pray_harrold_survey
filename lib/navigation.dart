import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/models/assessment.dart';
import 'package:pray_harrold_survey/ui/auth/link_account_screen.dart';
import 'package:pray_harrold_survey/ui/menu_pages/contact_me_screen.dart';
import 'package:pray_harrold_survey/ui/menu_pages/select_color_screen.dart';
import 'package:pray_harrold_survey/ui/post_subject_screen.dart';
import 'package:pray_harrold_survey/ui/subject_detail_screen.dart';

import 'models/person.dart';
import 'models/subject.dart';

class GoTo {
  static postSubject(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostSubjectScreen()));
  }

  static subjectDetail(BuildContext context, Subject subject, Assessment assessment) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubjectDetailScreen(subject, assessment)));
  }

  static contact(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContactMeScreen()));
  }

  static linkAccount(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LinkAccountScreen()));
  }

  static colours(BuildContext context, Person person) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SelectColorScreen()));
  }
}
