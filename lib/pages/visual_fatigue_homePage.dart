import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/color_temperature_screen.dart';
import 'package:spm/pages/vfd_test/color_challenge.dart';
import 'vfd_test/face_detector_view.dart';

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
      body: Container(
        color: Colors.green[100],
        child: Stack(
          children: <Widget>[
            // Semi-Transparent Overlay
            Container(
              color: Colors.white.withOpacity(0.3), // Adjust opacity
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Card 1
                  InkWell(
                    onTap: () {
                      // Color Temperature Preferences screen navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FaceDetectorView(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.color_lens, size: 40, color: Colors.green),
                            SizedBox(height: 10),
                            Text(
                              'Adjust Color Temperature',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Adjust the color temperature to your preference.',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Spaces between cards

                  // Card 1
                  InkWell(
                    onTap: () {
                      // Color Temperature Preferences screen navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ColorTemperatureScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.color_lens, size: 40, color: Colors.green),
                            SizedBox(height: 10),
                            Text(
                              'Adjust Color Temperature',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Adjust the color temperature to your preference.',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
      
                  // Card 2
                  InkWell(
                    onTap: () {
                      // Color Identification Challenge navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ColorIdentificationPage(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.palette, size: 40, color: Colors.orange),
                            SizedBox(height: 10),
                            Text(
                              'Start Color Identification Challenge',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'A challenge to identify colors and their names.',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
