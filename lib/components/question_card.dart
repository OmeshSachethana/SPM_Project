import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final Function(String) onOptionSelected;
  final Map<int, String> userResponses;
  final int currentQuestionIndex;
  final Function(bool) onNextButtonPressed;
  final Function() onBackButtonPressed;
  final int questionNumber;

  QuestionCard({
    required this.question,
    required this.onOptionSelected,
    required this.userResponses,
    required this.currentQuestionIndex,
    required this.onNextButtonPressed,
    required this.onBackButtonPressed,
    required this.questionNumber,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    selectedOption = widget.userResponses[widget.currentQuestionIndex];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          SizedBox(
            // width: 300,
            child: Text(
              'Question ${widget.questionNumber}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 220,
            width: 500,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.blueGrey[200],
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 300,
                    child: Text(
                      widget.question.questionText,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.question.options.length,
              itemBuilder: (BuildContext context, int index) {
                final option = widget.question.options[index];
                bool isSelected = selectedOption == option;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                    widget.onOptionSelected(option);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      color: isSelected
                          ? Colors.blue
                          : const Color.fromARGB(255, 137, 214, 86),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          //const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 50),
                  ),
                ),
                onPressed: () {
                  widget.onBackButtonPressed();
                },
                child: const Text('Back'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 50),
                  ),
                ),
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
                child: const Text('Next'), //next
              ),
            ],
          ),
        ],
      ),
    );
  }
}
