import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/question_card.dart';
import '../models/question.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

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

  Future<void> generatePDF(
      Map<int, String> userResponses, List<Question> questions) async {
    final roboto =
        pw.Font.ttf(await rootBundle.load("fonts/Roboto-Regular.ttf"));
    final robotoBold =
        pw.Font.ttf(await rootBundle.load("fonts/Roboto-Bold.ttf"));
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Text('Quiz Results',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: roboto)),
              pw.SizedBox(height: 20),
              for (var i = 0; i < questions.length; i++)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'Question ${i + 1}: ${questions[i].questionText}',
                        style: pw.TextStyle(
                            font: roboto, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'Question ${i + 1}: ${questions[i].questionText}',
                        style: pw.TextStyle(
                          font:
                              robotoBold, // <-- Use robotoBold for bold styling
                          fontWeight: pw.FontWeight
                              .bold, // <-- Ensure this is set to bold
                        ),
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'Correct Answer: ${questions[i].correctAnswer}',
                        style: pw.TextStyle(font: roboto, color: PdfColors.red),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                ),
            ],
          );
        },
      ),
    );

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/quiz_results.pdf');
      await file.writeAsBytes(await pdf.save());
    } else {
      throw Exception('Permission denied');
    }
  }

  void requestPermission() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses);
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
                ElevatedButton(
                  onPressed: () async {
                    await generatePDF(userResponses, questions);
                    final output = await getApplicationDocumentsDirectory();
                    final file = File('${output.path}/quiz_results.pdf');
                    await Share.shareFiles(['${output.path}/quiz_results.pdf'],
                        mimeTypes: ['application/pdf']);
                  },
                  child: const Text('Download Results PDF'),
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
          questionNumber: currentQuestionIndex + 1,
        );
      },
    );
  }
}
