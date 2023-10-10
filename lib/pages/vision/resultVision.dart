import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/vision/vision.dart';
import 'package:spm/services/api_services.dart';
import '../home_page.dart';

class ResultVision extends StatefulWidget {
  final CameraDescription frontCamera;
  final double percentage;
  const ResultVision({
    super.key,
    required this.percentage,
    required this.frontCamera,
  });

  @override
  State<ResultVision> createState() => _ResultVisionState();
}

class _ResultVisionState extends State<ResultVision> {
  MyApiService apiService = MyApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 122, 47),
          title: const Text('Result'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 300,
                    height: 500,
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.green[100],
                    child: Column(
                      children: [
                        const Text(
                          'Percentage',
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green,
                            ),
                            value: widget.percentage / 100,
                            semanticsLabel:
                                '${widget.percentage.toStringAsFixed(2)}%',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${widget.percentage.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Vision(
                        frontCamera: widget.frontCamera,
                      ),
                    ),
                  );
                },
                child: const Text('Start Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
