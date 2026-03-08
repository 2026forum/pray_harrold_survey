import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/comments/comments_controller.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';
import 'package:pray_harrold_survey/util/error_loader.dart';
import 'package:pray_harrold_survey/util/show_messages.dart';

import '../constants.dart';
import '../util/text_validation.dart';

const int kIssueMaxChar = 29; //exact length of phrase "climate change/global warming"
const int kMinimumComment = 10;

const kCreationScreenTitle = "What's the important thing?";
const kIssueHint = "name of thing";
const kIssueCommentAsk = "Why do you think this needs to be talked about?";
const kCreateButtonText = "press here to put this item on the board";
const kShortCommentText = "comment must be sufficient";

class PostSubjectScreen extends ConsumerStatefulWidget {
  const PostSubjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostSubjectScreenState();
}

class _PostSubjectScreenState extends ConsumerState<PostSubjectScreen> {
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();

  void _postSubject() {
    if (isValidTextValue(_titleController)) {
      if (validTextValueReturner(_commentController).length < kMinimumComment) {
        showSnackyBar(context, kShortCommentText);
        return;
      }

      ref
          .read(subjectsControllerProvider.notifier)
          .postSubject(context, validTextValueReturner(_titleController), validTextValueReturner(_commentController));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(subjectsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(kCreationScreenTitle)),
      body: isLoading
          ? Center(child: const Loader())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextField(
                        maxLength: kIssueMaxChar,
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: kIssueHint),
                      ),
                      Column(
                        children: [
                          const Text(kIssueCommentAsk),
                          TextField(
                            maxLength: kCommentMaxChar,
                            minLines: 3,
                            maxLines: 5,
                            controller: _commentController,
                            decoration: InputDecoration(border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _postSubject,
                        child: Padding(padding: const EdgeInsets.all(8.0), child: const Text(kCreateButtonText)),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _commentController.dispose();
  }
}
