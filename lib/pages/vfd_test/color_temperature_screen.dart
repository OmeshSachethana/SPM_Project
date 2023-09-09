import 'package:flutter/material.dart';

class ColorTemperatureScreen extends StatefulWidget {
  const ColorTemperatureScreen({super.key});

  @override
  _ColorTemperatureScreenState createState() => _ColorTemperatureScreenState();
}

class _ColorTemperatureScreenState extends State<ColorTemperatureScreen> {
  double colorTemperature = 5000; // Default color temperature in Kelvin
  double brightness = 50; // Default brightness (0 to 100)
  double viewingTime = 30; // Default viewing time in minutes

  // Calculate eye fatigue based on color temperature, brightness, and viewing time
  double calculateEyeFatigue() {
    // Simple formula (you can replace this with a more complex model)
    // Eye fatigue increases as color temperature deviates from 5000K,
    // brightness increases, and viewing time extends.
    double colorTempFactor = ((colorTemperature - 5000) / 5000).abs();
    double brightnessFactor = brightness / 100;
    double viewingTimeFactor = viewingTime / 60;

    return (colorTempFactor + brightnessFactor + viewingTimeFactor) * 100;
  }

  // Update the background color based on color temperature and brightness
  Color getBackgroundColor() {
    double colorTempFactor =
        (colorTemperature - 2000) / (10000 - 2000); // Normalize the temperature
    Color? baseColor = Color.lerp(Colors.red, Colors.blue, colorTempFactor);
    if (baseColor != null) {
      double brightnessFactor = brightness / 100;

      // Apply brightness adjustment to the base color
      return Color.fromRGBO(
        (baseColor.red * brightnessFactor).toInt(),
        (baseColor.green * brightnessFactor).toInt(),
        (baseColor.blue * brightnessFactor).toInt(),
        1.0,
      );
    } else {
      // Default color if lerp result is null (shouldn't normally happen)
      return Colors.white; // You can choose a different default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Temperature Preferences'),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
      ),
      body: Container(
        color: getBackgroundColor(), // Set the background color dynamically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // Note for the user
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.7), // Semi-transparent black background
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
                'Viewing Time (minutes): ${viewingTime.toStringAsFixed(0)}',
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
                  value: viewingTime,
                  min: 1,
                  max: 120,
                  onChanged: (value) {
                    setState(() {
                      viewingTime = value;
                    });
                  },
                ),
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
