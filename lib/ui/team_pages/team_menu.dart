import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/features/auth/auth_controller.dart';
import 'package:pray_harrold_survey/navigation.dart';

class TeamMenu extends ConsumerWidget {
  const TeamMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("HIIIIII")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                GoTo.thoughts(context);
              },
              child: const Text("THOUGHTS"),
            ),
            ElevatedButton(
              onPressed: () {
                GoTo.logCoordinates(context);
              },
              child: const Text("LOG COORDANITES"),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logOut(context);
              },
              child: const Text("LOG OUT"),
            ),
            const SizedBox(height: 1.0,)
          ],
        ),
      ),
    );
  }
}
