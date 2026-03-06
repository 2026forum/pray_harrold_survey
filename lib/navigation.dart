import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/ui/raise_item_screen.dart';


class GoTo {
  static raiseItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RaiseItemScreen()));
  }

  // static issueDetailScreen(BuildContext context, Issue issue){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssueCommentsScreen(issue)));
  // }
}
