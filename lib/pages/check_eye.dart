import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Eye_reports/blind_report.dart';
import 'package:spm/pages/Eye_reports/vsion_report.dart';
import 'package:spm/pages/blindness/blindness.dart';
import 'package:spm/pages/home_page.dart';
import 'package:spm/pages/vision/vision.dart';

class CheckEye extends StatelessWidget {
  final CameraDescription frontCamera;

  const CheckEye({Key? key, required this.frontCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(frontCamera: frontCamera),
                ),
              );
            },
          ),
          title: const Text('Home'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CardButton(
                  imageUrl: 'lib/images/eye_logoblid.png',
                  buttonName: 'Eye Vision',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Vision(
                          frontCamera: frontCamera,
                        ),
                      ),
                    );
                  },
                  onStartTestPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Vision(
                          frontCamera: frontCamera,
                        ),
                      ),
                    );
                    // Handle "Start Test" button press here
                    // For example, you can navigate to the test screen.
                  },
                  onReportPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VisionResultViewPage()));
                    // Handle "Report" button press here
                    // For example, you can navigate to the report screen.
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CardButton(
                  buttonName: 'Color Blindness',
                  imageUrl: 'lib/images/blind.jpg',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Vision(
                          frontCamera: frontCamera,
                        ),
                      ),
                    );
                  },
                  onStartTestPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Blindness(
                          frontCamera: frontCamera,
                        ),
                      ),
                    );
                    // Handle "Start Test" button press here
                    // For example, you can navigate to the test screen.
                  },
                  onReportPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ResultViewPage()));
                    // Handle "Report" button press here
                    // For example, you can navigate to the report screen.
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String imageUrl;
  final String buttonName;
  final VoidCallback onPressed;
  final VoidCallback onStartTestPressed;
  final VoidCallback onReportPressed;

  const CardButton({
    required this.imageUrl,
    required this.buttonName,
    required this.onPressed,
    required this.onStartTestPressed,
    required this.onReportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            buttonName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            imageUrl,
            width: 110,
            height: 150,
          ),
          const SizedBox(
            height: 26,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onStartTestPressed,
                child: const Text('Start Test'),
              ),
              ElevatedButton(
                onPressed: onReportPressed,
                child: const Text('Report'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
