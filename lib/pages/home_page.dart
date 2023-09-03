import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/visual_fatigue_homePage.dart';

class HomePage extends StatelessWidget {
  final CameraDescription frontCamera;

  const HomePage({Key? key, required this.frontCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualFatigueTestPage(
                        frontCamera: frontCamera), // Pass the front camera
                  ),
                );
              },
              child: const Text('Start Visual Fatigue Test'),
            ),
          ],
        ),
      ),
    );
  }
}
