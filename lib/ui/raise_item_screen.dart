import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/util/show_messages.dart';

import '../constants.dart';
import '../features/auth/items/items_controller.dart';
import '../util/text_validation.dart';

const int kIssueMaxChar = 29; //exact length of phrase "climate change/global warming"
const int kMinimumComment = -1; //15;

const kCreationScreenTitle = "What's the important thing?";
const kIssueHint = "name of thing";
const kIssueCommentAsk = "Why do you think this needs to be talked about?";
const kCreateButtonText = "press here to put this thing on the board";
const kShortCommentText = "comment must be sufficient";

class RaiseItemScreen extends ConsumerStatefulWidget {
  const RaiseItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RaiseItemScreenState();
}

class _RaiseItemScreenState extends ConsumerState<RaiseItemScreen> {
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();

  void _raiseItem() {
    if (isValidTextValue(_nameController)) {
      if (validTextValueReturner(_commentController).length < kMinimumComment) {
        showSnackyBar(context, kShortCommentText);
        return;
      }
      final formattedIssueText = validTextValueReturner(_nameController);
      ref.read(itemsControllerProvider.notifier).postItem(formattedIssueText, context, validTextValueReturner(_commentController));
      Navigator.of(context).pop();
    }
  }

  //TODO USE NOTIFIER!!!!!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kCreationScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  maxLength: kIssueMaxChar,
                  controller: _nameController,
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
                ElevatedButton(onPressed: _raiseItem, child: const Text(kCreateButtonText)),
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
    _nameController.dispose();
    _commentController.dispose();
  }
}
