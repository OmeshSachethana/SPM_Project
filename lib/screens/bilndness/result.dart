import 'package:flutter/material.dart';

import '../home/home.dart';


class ResultPage extends StatefulWidget {
  final double percentage;
  const ResultPage({super.key, required this.percentage}) ;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
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
