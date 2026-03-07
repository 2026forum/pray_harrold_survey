import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_harrold_survey/util/error_loader.dart';

import '../../features/auth/alias_engine.dart';
import '../../features/auth/auth_controller.dart';
import '../../util/text_validation.dart';

//APP BAR TEXT
const kTitleText = "Welcome to the Marselina project!";

//Selection option text
const kUsernameText = "Choose your own username";

//Username generation text
const kAliasButtonText = "or generate a username";
//"GO" button text
const kGoButtonText = "Begin!";
////////////////////////////////////////////////////////

//BLACK BOX/////////////WIDGET//////////////

//TODO USE NOTIFIER!!!!
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _nameController = TextEditingController();
  bool _customName = true;
  bool _generateName = false;


  String alias = "SillyBandwagon";

  @override
  void initState() {
    super.initState();
    alias = AliasEngine.name;
  }

  void _useApp() {
    ref
        .read(authControllerProvider.notifier)
        .useWithoutAccount(_customName && isValidTextValue(_nameController) ? validTextValueReturner(_nameController) : alias, context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(kTitleText), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: isLoading
              ? const Loader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CheckboxListTile(
                          title: const Text(kUsernameText),
                          value: _customName,
                          onChanged: (value) {
                            setState(() {
                              _customName = value!;
                              if (_customName) {
                                _generateName = false;
                              }
                            });
                          },
                        ),
                        if (_customName)
                          TextField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(border: OutlineInputBorder()),
                          ),
                      ],
                    ),

                    if (_generateName) Text(alias, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    if (!_customName && !_generateName) const SizedBox(height: 44),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          alias = AliasEngine.name;
                          _customName = false;
                          _generateName = true;
                        });
                      },
                      child: const Text(kAliasButtonText),
                    ),
                    Column(
                      children: [
                        ElevatedButton(onPressed: _useApp, child: const Text(kGoButtonText)),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }
}
