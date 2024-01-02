import 'package:flutter/material.dart';
import 'package:spm/pages/vfd_test/colour_palettes/colour_palette_2.dart';
import 'colour_palettes/colour_palette_1.dart';

class LineThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const LineThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: 5.0, // This is the width of the line
        height: parentBox.size.height, // This is the height of the line
      ),
      paint,
    );
  }
}

class ColorIdentificationPage extends StatefulWidget {
  @override
  _ColorIdentificationPageState createState() =>
      _ColorIdentificationPageState();
}

class _ColorIdentificationPageState extends State<ColorIdentificationPage> {
  double sliderValue1 = 0.0;
  Color selectedColor1 = Colors.red;
  double sliderValue2 = 0.0;
  Color selectedColor2 = Colors.red;
  List<double> confirmedSliderValues1 = [];
  List<Color> colors1 = [
    Color(0xFFFF6565),
    Color(0xFF740075),
    Color(0xFFFFB168),
    Color(0xFFBECD86),
    Color(0xFF2C3E2E),
  ];

  @override
  void initState() {
    super.initState();
    colors1.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identify Colours',
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ColorPalette1(confirmedSliderValues1: confirmedSliderValues1, colors: colors1, selectedColor: selectedColor1),
              SizedBox(height: 50.0),
              _buildColorPalette(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    confirmedSliderValues1.add(sliderValue1);
                  });
                },
                child: Text('Confirm Color'),
              ),
              SizedBox(height: 50.0),
              ColorPalette2(),
              SizedBox(height: 50.0),
              _buildColorPalette2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPalette() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: colors1,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 0.0, // This makes the slider track invisible
            thumbShape: LineThumbShape(), // Use the custom thumb shape
          ),
          child: Slider(
            value: sliderValue1,
            onChanged: (double value) {
              setState(() {
                sliderValue1 = value;
                selectedColor1 =
                    getColorAtPosition(sliderValue1, colors1);
              });
            },
          ),
        ),
      ],
    );
  }

  Color getColorAtPosition(double position, List<Color> colors) {
    final sectionWidth = 1.0 / colors.length;
    final int sectionIndex = (position / sectionWidth).floor();
    final double positionInSection =
        (position - sectionIndex * sectionWidth) / sectionWidth;
    return Color.lerp(
        colors[sectionIndex], colors[sectionIndex + 1], positionInSection)!;
  }

  Widget _buildColorPalette2() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                Color(0xFF23243B),
                Color(0xFF334E62),
                Color(0xFFD5DADF),
                Color(0xFFF1B8C9),
                Color(0xFFF3ACAB),
                Color(0xFF9180C1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 0.0, // This makes the slider track invisible
            thumbShape: LineThumbShape(), // Use the custom thumb shape
          ),
          child: Slider(
            value: sliderValue2,
            onChanged: (double value) {
              setState(() {
                sliderValue2 = value;
                selectedColor2 = Color.lerp(Colors.red, Colors.black, value)!;
              });
            },
          ),
        ),
      ],
    );
  }
}
