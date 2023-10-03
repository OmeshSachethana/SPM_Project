import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/blindness/blindness.dart';
import 'package:spm/services/api_services.dart';
import '../home_page.dart';

class ResultPage extends StatefulWidget {
  final CameraDescription frontCamera;
  final double percentage;
  const ResultPage(
      {super.key, required this.percentage, required this.frontCamera});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  MyApiService apiService = MyApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 122, 47),
          title: const Text('Result '),
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
                  height: 400,
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
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(0),
                    ),
                  );*/

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Blindness(
                        frontCamera: widget.frontCamera,
                      ),
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
