import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/models/assessment.dart';
import 'package:pray_harrold_survey/ui/auth/link_account_screen.dart';
import 'package:pray_harrold_survey/ui/auth/login_screen.dart';
import 'package:pray_harrold_survey/ui/menu_pages/contact_me_screen.dart';
import 'package:pray_harrold_survey/ui/menu_pages/personal_options_screen.dart';
import 'package:pray_harrold_survey/ui/menu_pages/select_color_screen.dart';
import 'package:pray_harrold_survey/ui/post_subject_screen.dart';
import 'package:pray_harrold_survey/ui/subject_detail_screen.dart';
import 'package:pray_harrold_survey/ui/team_pages/geolog_screen.dart';
import 'package:pray_harrold_survey/ui/team_pages/team_menu.dart';
import 'package:pray_harrold_survey/ui/team_pages/thoughts_screen.dart';
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

  static logIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static colours(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SelectColorScreen()));
  }
  static userSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PersonalOptionsScreen()));
  }

  ///TEAM PAGES
  static teamPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TeamMenu()));
  }

  static thoughts(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ThoughtsScreen()));
  }

  static logCoordinates(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GeologScreen()));
  }
}
