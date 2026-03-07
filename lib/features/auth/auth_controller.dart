import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pray_harrold_survey/features/auth/auth_repository.dart';
import 'package:pray_harrold_survey/models/person.dart';

import '../../util/show_messages.dart';

final personProvider = StateProvider<Person?>((ref) => null);

final authControllerProvider = NotifierProvider.autoDispose<AuthController, bool>(AuthController.new);

class AuthController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  useWithoutAccount(BuildContext context, String username) async {
    state = true;
    final result = await _authRepository.signUp(username);
    state = false;
    result.fold((l) => showSnackyBar(context, l.message), (r) {});
  }

  linkAccount(BuildContext context, String email, String password) async {
    state = true;
    final result = await _authRepository.linkAcount(email, password);
    result.fold((l) => showSnackyBar(context, l.message), (r) {
      Navigator.pop(context);
    });
  }
}
