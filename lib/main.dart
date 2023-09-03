import 'package:spm/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import the camera package

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final frontCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front,
  );
  runApp(MyApp(frontCamera: frontCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription frontCamera;

  const MyApp({Key? key, required this.frontCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customize your app's theme here
      ),
      home: HomePage(frontCamera: frontCamera), // Pass the front camera to your home page
    );
  }
}

