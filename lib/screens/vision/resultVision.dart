import 'package:flutter/material.dart';
import 'package:spm/screens/vision/vision.dart';

class ResultVision extends StatefulWidget {
  final double percentage;
  const ResultVision({super.key, required this.percentage});

  @override
  State<ResultVision> createState() => _ResultVisionState();
}

class _ResultVisionState extends State<ResultVision> {
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
                child: Container(
                  width: 300,
                  height: 500,
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.blue,
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
                      Text(
                        '${widget.percentage.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 70.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Vision(),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}