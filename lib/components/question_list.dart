import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/question_card.dart';
import '../models/question.dart';

class QuestionList extends StatefulWidget {
  @override
  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  Map<int, String> userResponses = {};

  void handleBackButtonPress() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('questions').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        questions.clear();
        final docs = snapshot.data!.docs;

        for (var doc in docs) {
          List<String> options = List<String>.from(doc['options']);
          questions.add(Question(
            id: doc.id,
            questionText: doc['question'],
            options: options,
            correctAnswer: doc['correctAnswer'],
          ));
        }

        if (currentQuestionIndex >= questions.length) {
          int correctAnswers = 0;
          userResponses.forEach((index, response) {
            if (response == questions[index].correctAnswer) {
              correctAnswers++;
            }
          });

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Quiz Completed!'),
                Text('Correct Answers: $correctAnswers/${questions.length}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuestionIndex = 0;
                      userResponses.clear();
                    });
                  },
                  child: const Text('Restart Quiz'),
                ),
              ],
            ),
          );
        }

        return QuestionCard(
          question: questions[currentQuestionIndex],
          onOptionSelected: (selectedOption) {
            userResponses[currentQuestionIndex] = selectedOption;
          },
          userResponses: userResponses,
          currentQuestionIndex: currentQuestionIndex,
          onNextButtonPressed: (isCorrect) {
            setState(() {
              currentQuestionIndex++;
            });
          },
          onBackButtonPressed: handleBackButtonPress,
        );
      },
    );
  }
}
