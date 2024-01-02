import 'package:flutter/material.dart';
import '../../components/question_list.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
        title: const Text('Q U I Z'),
      ),
      backgroundColor: Colors.green[100],
      body: QuestionList(),
    );
  }
}
