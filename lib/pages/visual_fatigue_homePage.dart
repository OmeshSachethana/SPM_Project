import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/color_temperature_screen.dart';
import 'package:spm/pages/vfd_test/main_page.dart';

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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Eye Line Up Setup'),
                            content: const Text(
                                'Please ensure that your eye is properly lined up before proceeding.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Proceed'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 200,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.visibility,
                                  size: 60, color: Colors.blue),
                              SizedBox(height: 10),
                              Text(
                                'Eye Fatigue Test',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Eye Fatigue Index measures eye strain based on \nblink frequency.',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Spaces between cards

                  // Card 2
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
                      child: Container(
                        height: 200,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.color_lens,
                                  size: 60, color: Colors.green),
                              SizedBox(height: 10),
                              Text(
                                'Adjust Color Temperature',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Adjust the color temperature to your preference.',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
