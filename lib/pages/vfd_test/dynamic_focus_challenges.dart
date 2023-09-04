import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final frontCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front,
  );

  runApp(
    MaterialApp(
      home: DynamicFocusChallengesPage(frontCamera: frontCamera),
    ),
  );
}

class DynamicFocusChallengesPage extends StatelessWidget {
  final CameraDescription frontCamera;

  const DynamicFocusChallengesPage({Key? key, required this.frontCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Focus Challenges'),
      ),
      body: Center(
        child: FocusChallenges(frontCamera: frontCamera),
      ),
    );
  }
}

class FocusChallenges extends StatelessWidget {
  final CameraDescription frontCamera;

  FocusChallenges({super.key, required this.frontCamera});

  final List<String> challenges = [
    'Challenge 1: Focus on a nearby object (Move closer to the camera)',
    'Challenge 2: Focus on a distant object',
    'Challenge 3: Adjust focus in low light',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (String challenge in challenges)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                challenge,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Implement challenge-specific logic here
                  _openCameraPopup(context);
                },
                child: Text('Start Challenge'),
              ),
              SizedBox(height: 16), // Add space between challenges
            ],
          ),
      ],
    );
  }

  Future<void> _openCameraPopup(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Camera Challenge'),
        content: Container(
          width: 300, // Adjust the width as needed
          height: 300, // Adjust the height as needed
          child: CameraWidget(cameraDescription: frontCamera),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class CameraWidget extends StatefulWidget {
  final CameraDescription cameraDescription;

  const CameraWidget({super.key, required this.cameraDescription});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameraDescription,
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller),
    );
  }
}
