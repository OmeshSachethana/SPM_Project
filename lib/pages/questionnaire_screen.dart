import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/question_list.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire App'),
      ),
      body: QuestionList(),
    );
  }
}
