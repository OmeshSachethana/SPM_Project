import 'package:flutter/material.dart';

class DynamicFocusChallengesPage extends StatelessWidget {
  const DynamicFocusChallengesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Focus Challenges'),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
      ),
      body: Center(
        child: FocusChallenges(),
      ),
    );
  }
}

class FocusChallenges extends StatelessWidget {
  FocusChallenges({super.key});

  final List<String> challenges = [
    'Challenge No.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (String challenge in challenges)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                challenge,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16), // Add space between challenges
            ],
          ),
      ],
    );
  }
}
