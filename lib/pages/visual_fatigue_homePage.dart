import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/dynamic_focus_challenges.dart';
import 'package:spm/pages/vfd_test/color_temperature_screen.dart';
import 'package:spm/pages/vfd_test/color_challenge.dart';

class VisualFatigueTestPage extends StatelessWidget {
  final CameraDescription frontCamera;
  const VisualFatigueTestPage({Key? key, required this.frontCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Fatigue Index Test'),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/images/background_image.jpg'),
                fit: BoxFit.cover, // Adjust the image fit
              ),
            ),
          ),
          // Semi-Transparent Overlay
          Container(
            color: Colors.white.withOpacity(0.3), // Adjust opacity
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Dynamic Focus Challenges screen navigation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DynamicFocusChallengesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Start Dynamic Focus Challenges',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16), // Spaces between buttons
                ElevatedButton(
                  onPressed: () {
                    // Color Temperature Preferences screen navigation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ColorTemperatureScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Adjust Color Temperature',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Color Identification Challenge navigation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ColorIdentificationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Start Color Identification Challenge',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement the Visual Habit Survey screen navigation
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Take Visual Habit Survey',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
