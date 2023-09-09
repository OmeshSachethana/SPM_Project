import 'dart:math';
import 'package:flutter/material.dart';

class ColorIdentificationPage extends StatefulWidget {
  const ColorIdentificationPage({Key? key}) : super(key: key);

  @override
  _ColorIdentificationPageState createState() =>
      _ColorIdentificationPageState();
}

class _ColorIdentificationPageState extends State<ColorIdentificationPage> {
  late Color _currentColor;
  final List<String> _colorNames = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Cyan',
    'Teal',
  ];
  late String _correctColorName;
  bool _isCorrect = true;
  int _correctAnswers = 0;
  int _totalAnswers = 0;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _generateRandomColor();
  }

  void _generateRandomColor() {
    if (_totalAnswers == _colorNames.length) {
      // All colors have been answered, stop the quiz
      setState(() {
        _quizCompleted = true;
      });
      return;
    }

    final List<Color> customColors = [
      const Color.fromARGB(255, 247, 86, 86), // Red
      const Color.fromARGB(255, 42, 85, 186), // Blue
      const Color.fromARGB(255, 142, 255, 142), // Light Green
      const Color.fromARGB(255, 255, 255, 124), // Light Yellow
      const Color.fromARGB(255, 121, 106, 218), // Light Purple
      const Color.fromARGB(255, 255, 172, 76), // Light Orange
      const Color.fromARGB(255, 255, 113, 255), // Light Pink
      const Color.fromARGB(255, 150, 255, 255), // Light Cyan
      const Color(0xFF008080), // Teal
    ];

    final random = Random();
    final int index = random.nextInt(customColors.length);

    setState(() {
      _currentColor = customColors[index];
      _correctColorName = _colorNames[index];
    });
  }

  void _checkAnswer(String selectedColorName) {
    if (_quizCompleted) {
      return; // Quiz is completed, no need to check further
    }

    setState(() {
      _isCorrect = selectedColorName == _correctColorName;
      if (_isCorrect) {
        _correctAnswers++;
      }
      _totalAnswers++;

      if (_totalAnswers == _colorNames.length) {
        // All colors have been answered, calculate the visual fatigue index
        final double visualFatigueIndex =
            _correctAnswers / _totalAnswers; // You can use any formula here

        // Show the visual fatigue index in a dialog
        _showVisualFatigueIndex(visualFatigueIndex);
        // Set _quizCompleted here to ensure it's only set after showing the dialog
        _quizCompleted = true;
      } else {
        // Display correctness message in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_isCorrect ? 'Correct!' : 'Incorrect!'),
          duration: const Duration(seconds: 1), // Adjust the duration as needed
        ));
        _generateRandomColor(); // Generate a new question
      }
    });
  }

  void _showVisualFatigueIndex(double visualFatigueIndex) {
    // Round the visual fatigue index to two decimal places
    String formattedVisualFatigueIndex = visualFatigueIndex.toStringAsFixed(2);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Visual Fatigue Index'),
          content: Text(
              'Your visual fatigue index is: $formattedVisualFatigueIndex'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Identification Challenge'),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: _currentColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select the correct color',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  _quizCompleted
                      ? const Text(
                          'Quiz Completed!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                          ),
                        )
                      : const SizedBox(height: 20), // Blank space
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    children: _colorNames.map((colorName) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _quizCompleted
                              ? null // Disable button interaction
                              : () => _checkAnswer(colorName),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Button background color
                            shadowColor: Colors.grey, // Shadow color
                            elevation: 5, // Shadow elevation
                          ),
                          child: Text(
                            colorName,
                            style: const TextStyle(
                              color: Colors.black, // Text color
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
