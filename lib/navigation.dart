import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/ui/post_subject_screen.dart';

class GoTo {
  static postSubject(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostSubjectScreen()));
  }

  // static issueDetailScreen(BuildContext context, Issue issue){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssueCommentsScreen(issue)));
  // }
}
