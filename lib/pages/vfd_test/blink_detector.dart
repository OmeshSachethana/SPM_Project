import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

class BlinkDetector extends StatefulWidget {
  final CameraDescription frontCamera;

  const BlinkDetector({Key? key, required this.frontCamera}) : super(key: key);

  @override
  _BlinkDetectorState createState() => _BlinkDetectorState();
}

class _BlinkDetectorState extends State<BlinkDetector> {
  int blinkCount = 0;
  late CameraController _controller;
  bool _isCameraReady = false;
  FaceDetector? faceDetector;

  @override
  void initState() {
    super.initState();
    initCamera();
    faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
      enableClassification: true,
    ));
  }

  Future<void> initCamera() async {
    _controller = CameraController(
      widget.frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isCameraReady = true;
      });
    });

    _controller.startImageStream((image) => detectBlinks(image));
  }

  @override
  Widget build(BuildContext context) {
    if (_isCameraReady) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: CameraPreview(_controller),
                ),
                SizedBox(height: 16),
                Text('Blink Count: $blinkCount'),
              ],
            ),
          ),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  bool _isProcessing = false;

  Future<void> detectBlinks(CameraImage image) async {
    if (_isProcessing) return;

    _isProcessing = true;
    try {
      InputImageFormat format;

      switch (image.format.raw) {
        case 35:
          format = InputImageFormat.yuv420;
          break;
        case 17:
          format = InputImageFormat.nv21;
          break;
        default:
          throw ArgumentError('Image format not supported');
      }

      final inputImage = InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: format,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await faceDetector!.processImage(inputImage);

      for (final face in faces) {
        final leftEyeOpen = face.leftEyeOpenProbability;
        final rightEyeOpen = face.rightEyeOpenProbability;

        if (leftEyeOpen != null && rightEyeOpen != null) {
          if (leftEyeOpen < 0.4 && rightEyeOpen < 0.4) {
            print('Blink detected');
            if (mounted) {
              // Check if the widget is currently part of the tree.
              setState(() {
                blinkCount++;
              });
            }
          }
        }
      }
    } catch (e) {
      // Handle any errors here
    } finally {
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    faceDetector?.close();
    super.dispose();
  }
}
