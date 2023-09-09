import 'dart:async';
import 'package:flutter/material.dart';

class ColorTemperatureScreen extends StatefulWidget {
  const ColorTemperatureScreen({super.key});

  @override
  _ColorTemperatureScreenState createState() => _ColorTemperatureScreenState();
}

class _ColorTemperatureScreenState extends State<ColorTemperatureScreen> {
  double colorTemperature = 5000; // Default color temperature in Kelvin
  double brightness = 50; // Default brightness (0 to 100)
  Timer? timer; // Timer to keep track of viewing time
  int secondsElapsed = 0; // Counter for elapsed time
  int totalViewingTime = 0; // Total viewing time in seconds

  // Calculate eye fatigue based on color temperature, brightness, and viewing time
  double calculateEyeFatigue() {
    double colorTempFactor = ((colorTemperature - 5000) / 5000).abs();
    double brightnessFactor = brightness / 100;
    double viewingTimeFactor = totalViewingTime / 60; // Convert to minutes

    return (colorTempFactor + brightnessFactor + viewingTimeFactor) * 100;
  }

  // Update the background color based on color temperature and brightness
  Color getBackgroundColor() {
    double colorTempFactor =
        (colorTemperature - 2000) / (10000 - 2000); // Normalize the temperature
    Color? baseColor = Color.lerp(Colors.red, Colors.blue, colorTempFactor);
    if (baseColor != null) {
      double brightnessFactor = brightness / 100;
      return Color.fromRGBO(
        (baseColor.red * brightnessFactor).toInt(),
        (baseColor.green * brightnessFactor).toInt(),
        (baseColor.blue * brightnessFactor).toInt(),
        1.0,
      );
    } else {
      return Colors.white;
    }
  }

  // Start the timer when the screen is created
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Start the timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
        totalViewingTime++;
      });
    });
  }

  // Cancel the timer when the screen is changed
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutesElapsed = secondsElapsed ~/ 60;
    final secondsRemaining = 60 - (secondsElapsed % 60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Temperature Preferences'),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
      ),
      body: Container(
        color: getBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Note for the user
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                child: const Text(
                  'For a better test result, move to a darker environment and use the maximum system brightness.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const Text(
                'Adjust Color Temperature Preferences',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                'Color Temperature (in Kelvin): ${colorTemperature.toStringAsFixed(0)}K',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.5),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withOpacity(0.3),
                ),
                child: Slider(
                  value: colorTemperature,
                  min: 2000,
                  max: 10000,
                  onChanged: (value) {
                    setState(() {
                      colorTemperature = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Brightness: ${brightness.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.5),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withOpacity(0.3),
                ),
                child: Slider(
                  value: brightness,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      brightness = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Viewing Time: ${minutesElapsed.toString().padLeft(2, '0')}:${secondsRemaining.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                'Eye Fatigue Level: ${calculateEyeFatigue().toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
