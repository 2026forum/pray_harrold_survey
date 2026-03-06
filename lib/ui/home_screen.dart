import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kAppBarText = "What's the most important thing?";

const Widget kIssueHeading = Text("      Item", style: TextStyle(fontWeight: FontWeight.bold));
const kUpVoteLeftHeading = "Productive";
const kDownVoteRightHeading = "Unproductive";

const Icon kUpvoteIcon = Icon(Icons.arrow_upward);
const Icon kDownvoteIcon = Icon(Icons.arrow_downward);

const kCommentAsk = "Why do you feel this way?";

const kAddIssueStatement = "Don't see it? add your response here.";


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
