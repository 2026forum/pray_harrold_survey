import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/constants.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/features/comments/comments_controller.dart';
import 'package:pray_harrold_survey/features/comments/comments_repository.dart';
import 'package:pray_harrold_survey/features/subjects/subjects_controller.dart';
import 'package:pray_harrold_survey/models/assessment.dart';
import 'package:pray_harrold_survey/ui/tiles/comment_tile.dart';
import 'package:pray_harrold_survey/util/error_loader.dart';
import 'package:pray_harrold_survey/util/show_messages.dart';
import 'package:pray_harrold_survey/util/text_validation.dart';

import '../models/comment.dart';
import '../models/person.dart';
import '../models/subject.dart';

class TopRightMenuText {
  static const comment = "Comment";
  static const undo = "Reset Assessment";
  static const vote = "Assess";
}

const kCommentsHeading = "Here's What They Are Saying";

const kOnUndoAction = "Assessment Cleared";

class UndoPrompt {
  static const initial = "So you want to reset your assessment?";
  static const agrees = "Not such a good idea after all?";
  static const disagrees = "Not as bad as you thought?";

  static const noJudgment = "You haven't decided about this yet!";
}

class PopUpVoterText {
  static const heading = "What Do You Think?";
  static const agree = "This is a productive thing to discuss.";
  static const disagree = "There are better things to talk about.";
  static const neutral = "I'm not sure.";
}

class SubjectDetailScreen extends ConsumerStatefulWidget {
  final Subject subject;
  final Assessment assessment;

  const SubjectDetailScreen(this.subject, this.assessment, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen> {
  final _commentController = TextEditingController();
  bool _hasComment = false;
  Assessment _assessment = Assessment.neutral;
  bool _commentsShuffled = false;
  @override
  void initState() {
    super.initState();
    _assessment = widget.assessment;
    _getUserComment();
  }

  void _getUserComment() async {
    await ref.read(commentsControllerProvider(widget.subject.subjectId)).getUserComment().then((comment) {
      if (comment != "") {
        _commentController.text = comment;
        _hasComment = true;
      }
    });
  }

  _makeComment() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("what do you say?"),
                TextField(controller: _commentController, maxLines: 3, maxLength: kCommentMaxChar),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Nevermind'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_hasComment && _commentController.text == "") {
                          ref.read(commentsControllerProvider(widget.subject.subjectId)).deleteComment();
                          Navigator.pop(context);
                        } else if (isValidTextValue(_commentController)) {
                          ref.read(commentsControllerProvider(widget.subject.subjectId)).addComment(validTextValueReturner(_commentController));
                          _hasComment = true;
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _undoVote(bool isUpvote) {
    if (isUpvote) {
      ref.read(subjectsControllerProvider.notifier).unAgree(widget.subject.subjectId);
    } else {
      ref.read(subjectsControllerProvider.notifier).unDisagree(widget.subject.subjectId);
    }
    setState(() {
      _assessment = Assessment.neutral;
    });
  }

  Widget _authoredTile(Comment comment) {
    return ListTile(
      title: Center(child: Text(comment.commentText)),
      subtitle: Center(child: Text(comment.author)),
      onTap: () => _makeComment(),
    );
  }

  _undoVoteDialog(String personId) {
    // IDEA TODO allow the user to indicate which comment, if any, changed their mind.
    String undoPrompt = UndoPrompt.initial;

    undoPrompt = (_assessment == Assessment.agrees)
        ? UndoPrompt.agrees
        : (_assessment == Assessment.disagrees)
        ? UndoPrompt.disagrees
        : UndoPrompt.noJudgment;
    final isFolly = (_assessment == Assessment.neutral);
    showDialog(
      context: context,
      builder: (context) => Dialog(
        constraints: BoxConstraints(maxHeight: 180, maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(undoPrompt),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!isFolly)
                    ElevatedButton(
                      onPressed: () {
                        _undoVote(_assessment == Assessment.agrees);
                        showSnackyBar(context, kOnUndoAction);
                        Navigator.pop(context);
                      },
                      child: const Text('undo assessment'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(isFolly ? "ok" : " actually nevermind"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showVoteDialog(Person person) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          constraints: BoxConstraints(minHeight: 200, maxHeight: 250, maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(PopUpVoterText.heading),
                RadioGroup<Assessment>(
                  groupValue: _assessment,
                  onChanged: (Assessment? value) {
                    setState(() {
                      _assessment = value!;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile<Assessment>(
                        value: Assessment.agrees,
                        title: const Text(PopUpVoterText.agree),
                        tileColor: _assessment == Assessment.agrees ? person.shadedProColor : null,
                      ),
                      RadioListTile<Assessment>(
                        value: Assessment.disagrees,
                        title: const Text(PopUpVoterText.disagree),
                        tileColor: _assessment == Assessment.disagrees ? person.shadedConColor : null,
                      ),
                      RadioListTile<Assessment>(value: Assessment.neutral, title: const Text(PopUpVoterText.neutral)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_assessment == Assessment.agrees) {
                                ref.read(subjectsControllerProvider.notifier).agree(widget.subject.subjectId);
                              } else if (_assessment == Assessment.disagrees) {
                                ref.read(subjectsControllerProvider.notifier).disagree(widget.subject.subjectId);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Assess'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    final judgementRendered = _assessment != Assessment.neutral;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.subject.title),
        actions: [
          //TODO customize Icons
          if (judgementRendered)
            Padding(padding: const EdgeInsets.all(8.0), child: Icon(_assessment == Assessment.agrees ? Icons.face : Icons.warning)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "comment") {
                  _makeComment();
                }
                if (value == "undoVote") {
                  _undoVoteDialog(person.uid);
                }
                if (value == "vote") {
                  _showVoteDialog(person);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'comment', child: const Text(TopRightMenuText.comment)),
                if (judgementRendered) PopupMenuItem(value: 'undoVote', child: const Text(TopRightMenuText.undo)),
                if (!judgementRendered) PopupMenuItem(value: 'vote', child: const Text(TopRightMenuText.vote)),
              ],
              child: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(kCommentsHeading, style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(thickness: 3),
            Expanded(
              child: ref
                  .watch(commentsFeedProvider(widget.subject.subjectId))
                  .when(
                    data: (commentList) {
                      while (!_commentsShuffled) {
                        commentList.shuffle();
                        _commentsShuffled = true;
                      }
                      return ListView.builder(
                        itemCount: commentList.length,
                        itemBuilder: (context, index) {
                          final comment = commentList[index];
                          if (comment.authorId == person.uid) {
                            return Column(children: [_authoredTile(comment), Divider()]);
                          }
                          return Column(children: [CommentTile(comment, widget.subject), const Divider()]);
                        },
                      );
                    },
                    error: (error, stackTrace) => ErrorText(error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
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
