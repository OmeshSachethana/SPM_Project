import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final Function(String) onOptionSelected;
  final Map<int, String> userResponses;
  final int currentQuestionIndex;
  final Function(bool) onNextButtonPressed;

  QuestionCard({
    required this.question,
    required this.onOptionSelected,
    required this.userResponses,
    required this.currentQuestionIndex,
    required this.onNextButtonPressed,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    selectedOption = widget.userResponses[widget.currentQuestionIndex];

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                widget.question.questionText,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: widget.question.options.map((option) {
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value.toString();
                    });
                    widget.onOptionSelected(value.toString());
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedOption != null) {
                  bool isCorrect =
                      selectedOption == widget.question.correctAnswer;
                  widget.onNextButtonPressed(isCorrect);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please select an option before proceeding.'),
                    ),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
