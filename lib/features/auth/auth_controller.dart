import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';

import '../../models/person.dart';
import '../../util/show_messages.dart';
import 'auth_repository.dart';

//TODO figure out stateProvider update
final personProvider = StateProvider<Person?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository}) : _authRepository = authRepository, super(false);

  useWithoutAccount(BuildContext context, String username) async {
    state = true;
    final result = await _authRepository.signUp(username);
    state = false;
    result.fold((l) => showSnackyBar(context, l.message), (r) {}); 
  }

  // linkAccount(BuildContext context, String email, String password, bool wantsCommunication, {String? preference}) async {
  //   state = true;
  //   final result = await _authRepository.linkAcount(email, password, wantsCommunication, preference: preference);
  //   state = false;
  //   result.fold(
  //     (l) async {
  //       if (l.message == "The email address is already in use by another account.") {
  //         final newResult = await _authRepository.logIn(email, password);
  //         newResult.fold((l) => showSnackyBar(context, l.message), (r) => Navigator.of(context).pop());
  //       } else {
  //         showSnackyBar(context, l.message);
  //       }
  //     },
  //     (r) {
  //       showSnackyBar(context, 'success');
  //       Navigator.of(context).pop();
  //     },
  //   );
  // }

  // logIn(BuildContext context, String email, String password) async {
  //   state = true;
  //   final result = await _authRepository.logIn(email, password);
  //   state = false;
  //   result.fold((l) => showSnackyBar(context, l.message), (r) => null);
  // }

  // signOut(BuildContext context) {
  //   _authRepository.signOut();
  //   while (Navigator.canPop(context)) {
  //     Navigator.pop(context);
  //   }
  // }
}
