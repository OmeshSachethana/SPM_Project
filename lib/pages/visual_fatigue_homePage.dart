import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/dynamic_focus_challenges.dart';

class VisualFatigueTestPage extends StatelessWidget {
  final CameraDescription frontCamera;
  const VisualFatigueTestPage({Key? key, required this.frontCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Fatigue Index Test'),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/images/background_image.jpg'), // Replace with your image path
                fit: BoxFit.cover, // Adjust the image fit
              ),
            ),
          ),
          // Semi-Transparent Overlay
          Container(
            color: Colors.white.withOpacity(0.3), // Adjust opacity as needed
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
                        builder: (context) => DynamicFocusChallengesPage(
                            frontCamera: frontCamera),
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
                const SizedBox(height: 16), // Spacer between buttons
                ElevatedButton(
                  onPressed: () {
                    // Implement the Color Temperature Preferences screen navigation
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
                    // Implement the Reading Comprehension Speed test navigation
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
                    'Start Reading Comprehension Test',
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
