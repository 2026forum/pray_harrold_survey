import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/util/text_validation.dart';

const kLinkAccountHeading = "Let's Make It Official";
const kButtonText = "OK!";

TextField customTextField({required TextEditingController controller, String? hintText, obscureText = false, outlineField = false}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(border: outlineField ? const OutlineInputBorder() : null, hintText: hintText),
    textAlign: TextAlign.center,
  );
}

class LinkAccountScreen extends ConsumerStatefulWidget {
  const LinkAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkAccountScreenState();
}

class _LinkAccountScreenState extends ConsumerState<LinkAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Widget get _obscurePasswordSwitch => ElevatedButton(
    onPressed: () {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    },
    child: const Text('show password'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kLinkAccountHeading), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,

          children: [
            Column(
              children: [
                const Text('email'),
                customTextField(controller: _emailController, outlineField: true),
              ],
            ),
            Column(
              spacing: 5,
              children: [
                const Text('password'),
                customTextField(controller: _passwordController, outlineField: true, obscureText: _obscurePassword),
                Align(alignment: AlignmentGeometry.centerRight, child: _obscurePasswordSwitch),
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 60),
                    textStyle: TextStyle(fontSize: 36),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  ),
                  onPressed: () {
                    ref
                        .read(authControllerProvider.notifier)
                        .linkAccount(context, validTextValueReturner(_emailController), validTextValueReturner(_passwordController));
                  },
                  child: const Text(kButtonText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
