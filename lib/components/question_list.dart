import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/question_card.dart';
import '../models/question.dart';

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  Map<int, String> userResponses = {};

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('questions').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        try {
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
        } catch (e) {
          return Text('Error loading questions: $e');
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
                Text('Quiz Completed!'),
                Text('Correct Answers: $correctAnswers/${questions.length}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuestionIndex = 0;
                      userResponses.clear();
                    });
                  },
                  child: Text('Restart Quiz'),
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
        );
      },
    );
  }
}
