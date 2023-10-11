import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/face_detector_view.dart';
import 'package:spm/pages/vfd_test/gazing_challenge_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int blinkCount = 0;
  bool isGameStarted = false;
  Offset eyePosition = Offset.zero;

  final faceDetectorViewKey = GlobalKey<FaceDetectorViewState>();

  void updateBlinkCount(int newBlinkCount) {
    if (mounted) {
      setState(() {
        blinkCount = newBlinkCount;
      });
    }
  }

  void startGame() {
    // Add this method
    setState(() {
      isGameStarted = true;
      blinkCount = 0;
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

  void updateEyePosition(Offset newEyePosition) {
    if (mounted) {
      setState(() {
        eyePosition = newEyePosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GazingChallengePage(
              blinkCount: blinkCount,
              updateBlinkCount: updateBlinkCount,
              startGame: startGame,
              endGame: endGame,
              eyePosition: eyePosition),
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
            onEyePositionUpdated: updateEyePosition,
            isGameStarted: isGameStarted,
          ),
        ),
      ],
    );
  }
}
