import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'detector_view.dart';
import 'painters/face_detector_painter.dart';

typedef void BlinkCountCallback(int leftBlinkCount, int rightBlinkCount);

class FaceDetectorView extends StatefulWidget {
  final BlinkCountCallback? onBlinkCountUpdated;
  final bool isGameStarted;
  final Key? key;

  FaceDetectorView({this.key, this.onBlinkCountUpdated, required this.isGameStarted}) : super(key: key);

  @override
  State<FaceDetectorView> createState() => FaceDetectorViewState();
}

class FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  int leftBlinkCount = 0;
  int rightBlinkCount = 0;
  double blinkThreshold = 0.5;

  void resetBlinkCount() {
    setState(() {
      leftBlinkCount = 0;
      rightBlinkCount = 0;
    });
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final faces = await _faceDetector.processImage(inputImage);

    for (final face in faces) {
      // Check if both eyes are closed
      if (widget.isGameStarted && // Add this line
          face.leftEyeOpenProbability != null &&
          face.rightEyeOpenProbability != null &&
          face.leftEyeOpenProbability! < blinkThreshold &&
          face.rightEyeOpenProbability! < blinkThreshold) {
        leftBlinkCount++;
        rightBlinkCount++;
      }

      // Check if face is properly positioned
      final faceCenter = face.boundingBox.center;
      final imageWidth = inputImage.metadata?.size.width ?? 1;
      final imageHeight = inputImage.metadata?.size.height ?? 1;

      // Define your criteria for a "properly positioned" face
      if (faceCenter.dx > imageWidth * 0.1 && // Face is not too far on the left
          faceCenter.dx <
              imageWidth * 0.9 && // Face is not too far on the right
          faceCenter.dy > imageHeight * 0.1 && // Face is not too far on the top
          faceCenter.dy < imageHeight * 0.9) {
        // Face is not too far on the bottom
      }
    }

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      text += 'Blinks: $leftBlinkCount';
      _text = text;
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }

    if (widget.onBlinkCountUpdated != null) {
      widget.onBlinkCountUpdated!(leftBlinkCount, rightBlinkCount);
    }
  }
}
