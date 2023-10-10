import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/face_detector_view.dart';
import 'package:spm/pages/vfd_test/gazing_challenge_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int blinkCount = 0;
  bool isGameStarted = false; // Add this line

  final faceDetectorViewKey = GlobalKey<FaceDetectorViewState>();

  void updateBlinkCount(int newBlinkCount) {
    setState(() {
      blinkCount = newBlinkCount;
    });
  }

  void startGame() {
    // Add this method
    setState(() {
      isGameStarted = true;
      blinkCount = 0; // Reset blink count here
      faceDetectorViewKey.currentState
          ?.resetBlinkCount(); // Reset blink count in FaceDetectorView
    });
  }

  void endGame() {
    // Add this method
    setState(() {
      isGameStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GazingChallengePage(
              blinkCount: blinkCount,
              updateBlinkCount: updateBlinkCount,
              startGame: startGame, // Pass the method here
              endGame: endGame), // Pass the method here
        ),
        Expanded(
          child: FaceDetectorView(
            key: faceDetectorViewKey,
            onBlinkCountUpdated: (leftBlinkCount, rightBlinkCount) {
              if (isGameStarted) {
                // Only update if game has started
                updateBlinkCount(leftBlinkCount);
              }
            },
            isGameStarted: isGameStarted, // Pass the variable here
          ),
        ),
      ],
    );
  }
}
