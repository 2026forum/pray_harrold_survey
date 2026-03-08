import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("have an account?")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text('email'),
                TextField(controller: _emailController, textAlign: TextAlign.center,),
              ],
            ),
            Column(
              children: [
                const Text('password'),
                TextField(controller: _passwordController, obscureText: _obscurePassword,textAlign: TextAlign.center,),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Text(_obscurePassword ? 'show' : 'hide'),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logIn(context, _emailController.text, _passwordController.text);
              },
              child: const Text("Log In"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
