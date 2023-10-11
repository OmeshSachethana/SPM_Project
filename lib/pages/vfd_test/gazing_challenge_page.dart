import 'dart:async';

import 'package:flutter/material.dart';

class GazingChallengePage extends StatefulWidget {
  final int blinkCount;
  final Function(int) updateBlinkCount;
  final Function() startGame; // Add this line
  final Function() endGame; // Add this line

  GazingChallengePage(
      {required this.blinkCount,
      required this.updateBlinkCount,
      required this.startGame, // Add this line
      required this.endGame}) // Add this line
      : super();

  @override
  _GazingChallengePageState createState() => _GazingChallengePageState();
}

class _GazingChallengePageState extends State<GazingChallengePage> {
  bool _isGameStarted = false;
  int _remainingTime = 20;
  late Timer _timer;

  void _startGame() {
    setState(() {
      _isGameStarted = true;

      // Reset the remaining time and set a timer for 20 seconds
      _remainingTime = 20;
      _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    });

    widget.startGame();
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_remainingTime > 0) {
        _remainingTime--;
      } else {
        // Stop the timer when time is up
        timer.cancel();
        _isGameStarted = false;

        widget.endGame();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Gazing Challenge',
              style: TextStyle(fontSize: 24),
            ),
            if (!_isGameStarted)
              ElevatedButton(
                onPressed: _startGame,
                child: const Text('Start'),
              ),
            if (_isGameStarted)
              Column(
                children: [
                  Text(
                    'Time remaining: $_remainingTime seconds',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Blink count: ${widget.blinkCount}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
