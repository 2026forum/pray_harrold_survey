import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/auth/auth_controller.dart';
import '/features/auth/auth_repository.dart';
import '/location_service.dart';
import '/ui/auth_screen.dart';
import '/ui/home_screen.dart';
import '/ui/improperly_located_screen.dart';
import '/util/error_loader.dart';
import '/util/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool _isLocated = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() {
    isProperlyLocated().then((value) {
      setState(() {
        if (value) {
          _isLocated = true;
        } else {
          _isLocated = false;
        }
      });
    });
  }

  void _getData(User data) async {
    final person = await ref.read(authRepositoryProvider).getPersonData(data.uid).first;
    ref.read(personProvider.notifier).update((state) => person);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "Marselina",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF800000)), useMaterial3: false, scaffoldBackgroundColor: Colors.blue[70]),
    home: !_isLocated
        ? const ImproperlyLocatedScreen()
        : ref
              .watch(authStateChangeProvider)
              .when(
                data: (data) {
                  if (data != null) {
                    _getData(data);
                    return const HomeScreen();
                  }

                  return const AuthScreen();
                },
                error: (error, stackTrace) => ErrorPage(error.toString()),
                loading: () => const Loader(),
              ),
  );
}
