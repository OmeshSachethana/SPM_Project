import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DynamicFocusChallengesPage extends StatefulWidget {
  final CameraDescription frontCamera;

  const DynamicFocusChallengesPage({Key? key, required this.frontCamera})
      : super(key: key);

  @override
  _DynamicFocusChallengesPageState createState() =>
      _DynamicFocusChallengesPageState();
}

class _DynamicFocusChallengesPageState
    extends State<DynamicFocusChallengesPage> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.frontCamera,
      ResolutionPreset.medium, // Adjust the resolution as needed
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
      return Container(); // Return an empty container while the camera is initializing
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Focus Challenges'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
            const SizedBox(
                height:
                    16), // Add some space between the camera preview and challenges
            const FocusChallenges(), // Custom widget for focus challenges
          ],
        ),
      ),
    );
  }
}

class FocusChallenges extends StatefulWidget {
  const FocusChallenges({super.key});

  @override
  _FocusChallengesState createState() => _FocusChallengesState();
}

class _FocusChallengesState extends State<FocusChallenges> {
  int currentChallengeIndex = 0;
  List<String> challenges = [
    'Challenge 1: Focus on a nearby object',
    'Challenge 2: Focus on a distant object',
    'Challenge 3: Adjust focus in low light',
  ];

  void startChallenge() {
    // Implement challenge-specific logic here
    if (currentChallengeIndex < challenges.length - 1) {
      setState(() {
        currentChallengeIndex++;
      });
    } else {
      // All challenges completed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All challenges completed!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          challenges[currentChallengeIndex],
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: startChallenge,
          child: const Text('Start Challenge'),
        ),
      ],
    );
  }
}
