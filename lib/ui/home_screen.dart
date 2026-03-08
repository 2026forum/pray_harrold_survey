import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/navigation.dart';
import 'package:pray_harrold_survey/ui/tiles/subject_tile.dart';

import '../features/subjects/subjects_repository.dart';
import '../util/error_loader.dart';

const kAppBarText = "What's Important?";

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
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    final isVerified = person.isVerified;
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppBarText),
        centerTitle: true,
        leading: Center(
          child: PopupMenuButton(
            onSelected: (value) {
              if (value == 'colors') {
                GoTo.colours(context);
              }
              if (value == 'register') {
                GoTo.linkAccount(context);
              }
              if (value == 'Marcelina') {
                GoTo.teamPage(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "colors", child: const Text('Change Colors')),
                if (!isVerified) PopupMenuItem(value: "register", child: const Text('Register Email')),

                PopupMenuItem(value: "Marcelina", child: const Text('TEAM OPTIONS')),
              ];
            },
            child: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PopupMenuButton(
              onSelected: (value) {
                if (value == "contact") {
                  GoTo.contact(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [PopupMenuItem(value: "contact", child: const Text('contact'))];
              },
              child: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
                          return SubjectTile(subject, _commentController);
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

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }
}
