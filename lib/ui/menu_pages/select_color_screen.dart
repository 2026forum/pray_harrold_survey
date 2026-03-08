import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/auth_controller.dart';

const kPageTitle = "Choose Your Colors!";
const kPositiveText = "Choose Your \"Positive\" Color";
const kNegativeText = "Choose Your \"Negative\" Color";
const kSaveColors = "SAVE";

class SelectColorScreen extends ConsumerStatefulWidget {
  const SelectColorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectColorScreenState();
}

class _SelectColorScreenState extends ConsumerState<SelectColorScreen> {
  Color originalColor = Colors.green;
  Color originalColor2 = Colors.red;
  Color currentColor = Colors.green;
  Color pickerColor = Colors.green;
  Color currentColor2 = Colors.red;
  Color pickerColor2 = Colors.red;

  @override
  void initState() {
    super.initState();
    final person = ref.read(personProvider)!;
    setState(() {
      originalColor = person.proColor;
      originalColor2 = person.conColor;

      currentColor = person.proColor;
      pickerColor = currentColor;
      currentColor2 = person.conColor;
      pickerColor2 = currentColor2;
    });
  }

  Widget _colorCard(Color color) => Card(color: color, child: const SizedBox(height: 70, width: 120));

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }

  _selectColor2() {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(pickerColor: pickerColor2, onColorChanged: changeColor2),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor2 = pickerColor2);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }

  _selectColor() {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text(kPageTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(kPositiveText),
                  GestureDetector(onTap: _selectColor, child: _colorCard(currentColor)),
                ],
              ),
              Column(
                children: [
                  const Text(kNegativeText),
                  GestureDetector(onTap: _selectColor2, child: _colorCard(currentColor2)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 1.0, width: 1.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 60),
                  textStyle: TextStyle(fontSize: 36),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                ),
                onPressed: () {
                  if (currentColor != originalColor) {
                    ref.read(authControllerProvider.notifier).changeColor(true, currentColor.toARGB32());
                  }
                  if (currentColor2 != originalColor2) {
                    ref.read(authControllerProvider.notifier).changeColor(false, currentColor2.toARGB32());
                  }
                  Navigator.pop(context);
                },
                child: const Text(kSaveColors),
              ),
            ],
          ),
          const SizedBox(height: 1.0),
        ],
      ),
    );
  }
}
