import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GazingChallengePage extends StatefulWidget {
  final int blinkCount;
  final Function(int) updateBlinkCount;
  final Function() startGame;
  final Function() endGame;
  final Offset eyePosition;

  GazingChallengePage(
      {required this.blinkCount,
      required this.updateBlinkCount,
      required this.startGame,
      required this.endGame,
      required this.eyePosition})
      : super();

  @override
  _GazingChallengePageState createState() => _GazingChallengePageState();
}

class _GazingChallengePageState extends State<GazingChallengePage>
    with SingleTickerProviderStateMixin {
  bool _isGameStarted = false;
  int _remainingTime = 20;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<Color?> animation;
  List<Offset> eyePositions = [];

  double ballTop = 0;
  double ballLeft = 0;
  double ballSize = 50;
  double xSpeed = 2;
  double ySpeed = 3;

  double boxWidth = 400; // Custom width of the box
  double boxHeight = 230; // Custom height of the box

  @override
  void initState() {
    super.initState();
    _timer =
        Timer(Duration.zero, () {}); // Initialize _timer with a dummy Timer
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation = ColorTween(
            begin: Colors.green[100],
            end: const Color.fromARGB(255, 28, 122, 47))
        .animate(_controller);
    _controller.repeat(reverse: true);
  }

  void _startGame() {
    setState(() {
      _isGameStarted = true;
      _remainingTime = 20;
      _timer.cancel(); // Cancel the dummy timer
      _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);

      // Start the ball animation
      _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
        setState(() {
          ballLeft += xSpeed;
          ballTop += ySpeed;

          if (ballLeft < 0 || ballLeft + ballSize > boxWidth) {
            xSpeed = -xSpeed;
          }
          if (ballTop < 0 || ballTop + ballSize > boxHeight) {
            ySpeed = -ySpeed;
          }
        });
      });
    });
    widget.startGame();
  }

  void _updateTimer(Timer timer) {
    if (mounted) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          eyePositions.add(widget.eyePosition);
        } else {
          // Stop the timer when time is up
          timer.cancel();
          _isGameStarted = false;

          // Stop the ball animation
          _timer.cancel();

          double xMean =
              eyePositions.map((pos) => pos.dx).reduce((a, b) => a + b) /
                  eyePositions.length;
          double yMean =
              eyePositions.map((pos) => pos.dy).reduce((a, b) => a + b) /
                  eyePositions.length;
          double variance = eyePositions
                  .map((pos) => pow(pos.dx - xMean, 2) + pow(pos.dy - yMean, 2))
                  .reduce((a, b) => a + b) /
              (eyePositions.length - 1);

          // Calculate visual fatigue index and round to 2 decimal places
          double visualFatigueIndex = (widget.blinkCount / 20.0) + variance;
          String visualFatigueIndexRounded =
              visualFatigueIndex.toStringAsFixed(2);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Get the screen size
              var screenSize = MediaQuery.of(context).size;

              return AlertDialog(
                title: const Text('Gazing Challenge Completed'),
                content: Column(
                  children: [
                    const Text(
                        'Your Visual Fatigue Index based on eye position variance\n'),
                    Center(child: Text(visualFatigueIndexRounded)),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.4,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTextStyles: (context, value) =>
                                  const TextStyle(
                                color: Color(0xff72719b),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return '0s';
                                  case 5:
                                    return '5s';
                                  case 10:
                                    return '10s';
                                  case 15:
                                    return '15s';
                                  case 20:
                                    return '20s';
                                  default:
                                    return '';
                                }
                              },
                              margin: 8,
                            ),
                            leftTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: eyePositions
                                  .asMap()
                                  .entries
                                  .map((entry) => FlSpot(
                                      entry.key.toDouble(), entry.value.dy))
                                  .toList(),
                              isCurved: true,
                              colors: [Colors.blue],
                              barWidth: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );

          widget.endGame();
        }
      });
    } else {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      padding: const EdgeInsets.only(top: 28.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Gazing Challenge',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isGameStarted)
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: _startGame,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      animation.value!,
                                      const Color.fromARGB(255, 28, 122, 47),
                                    ],
                                    stops: <double>[0.0, 1.0],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Start',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  if (_isGameStarted)
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Time remaining: $_remainingTime seconds',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Blink count: ${widget.blinkCount}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  // Add this Stack to wrap the ball
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0), // Add padding to the top
                      child: Stack(children: [
                        Container(
                          width: boxWidth, // Width of the box
                          height: boxHeight, // Height of the box
                        ),
                        Positioned(
                            // Use Positioned widget to position the ball within the box
                            top: ballTop,
                            left: ballLeft,
                            child: Container(
                              width: ballSize / 1.5, // Size of the ball
                              height: ballSize / 1.5, // Size of the ball
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ))
                      ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _controller
        .dispose(); // Dispose the AnimationController to free up resources
    super.dispose();
  }
}
