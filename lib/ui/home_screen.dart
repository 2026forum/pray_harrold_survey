import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/navigation.dart';
import 'package:pray_harrold_survey/ui/widgets/subject_tile.dart';

import '../features/subjects/subjects_repository.dart';
import '../util/error_loader.dart';

const kAppBarText = "What's the most important thing?";

const Widget kListHeading = Text("      Item", style: TextStyle(fontWeight: FontWeight.bold));
const kUpVoteLeftHeading = "Productive";
const kDownVoteRightHeading = "Nonproductive";

const Icon kUpvoteIcon = Icon(Icons.arrow_upward);
const Icon kDownvoteIcon = Icon(Icons.arrow_downward);

const kCommentAsk = "Why do you feel this way?";

const kRaiseItemStatement = "Don't see it? add your response here.";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kAppBarText), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(kUpVoteLeftHeading), kListHeading, const Text(kDownVoteRightHeading)],
            ),
            const Divider(),
            Expanded(
              child: ref
                  .watch(subjectsFeedProvider)
                  .when(
                    data: (listOfSubjects) {
                      return ListView.builder(
                        itemCount: listOfSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = listOfSubjects[index];
                          return SubjectTile(subject);
                        },
                      );
                    },
                    error: (error, _) => ErrorText(error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
            TextButton(onPressed: () => GoTo.postSubject(context), child: const Text(kRaiseItemStatement)),
          ],
        ),
      ),
    );
  }
}
