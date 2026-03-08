import 'package:flutter/material.dart';
import 'package:pray_harrold_survey/location_service.dart';

Widget geoText(String text) => SelectableText(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32));

class GeologScreen extends StatefulWidget {
  const GeologScreen({super.key});

  @override
  State<GeologScreen> createState() => _GeologScreenState();
}

class _GeologScreenState extends State<GeologScreen> {
  late double latitude;
  late double longitude;
  late double accuracy;
  @override
  void initState() {
    super.initState();
    getPosition();
  }

  getPosition() async {
    final position = await determinePosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      accuracy = position.accuracy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async => await getPosition(), child: const Icon(Icons.eco)),
      appBar: AppBar(centerTitle: true, title: const Text("GEOLOG SCREEN")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextField(
                minLines: 3,
                maxLines: 5,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  hintText: "Enter a description of your location, press button to update coordanates and take a screenshot.",
                  border: OutlineInputBorder(),
                ),
              ),
              geoText("LATITUDE: ${latitude.toString()}"),
              geoText("LONGITUDE: ${longitude.toString()}"),
              const SizedBox(height: 1.0),
              Text("accuracy: ${accuracy.toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}
