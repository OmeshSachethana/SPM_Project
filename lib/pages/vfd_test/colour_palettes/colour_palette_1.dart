import 'package:flutter/material.dart';

class ColorPalette1 extends StatelessWidget {
  final List<double> confirmedSliderValues1;
  final List<Color> colors;
  final Color selectedColor;

  ColorPalette1({required this.confirmedSliderValues1, required this.colors, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 50),
      painter: PalettePainter(
          selectedValues: confirmedSliderValues1, colors: colors, selectedColor: selectedColor),
    );
  }
}

class PalettePainter extends CustomPainter {
  final List<double> selectedValues;
  final List<Color> colors;
  final Color selectedColor;

  PalettePainter({required this.selectedValues, required this.colors, required this.selectedColor});

  bool isSimilarColor(Color color1, Color color2) {
    return (color1.red - color2.red).abs() < 10 &&
        (color1.green - color2.green).abs() < 10 &&
        (color1.blue - color2.blue).abs() < 10;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Color(0xFFFF6565),
      Color(0xFF740075),
      Color(0xFFFFB168),
      Color(0xFFBECD86),
      Color(0xFF2C3E2E),
    ];
    final sectionWidth = size.width / colors.length;
    final borderRadius =
        BorderRadius.circular(10.0); // Adjust the border radius as needed

    for (var i = 0; i < colors.length; i++) {
      final paint = Paint()..color = colors[i];
      final sectionRect =
          Offset(sectionWidth * i, 0) & Size(sectionWidth, size.height);

      if (i == 0 || i == colors.length - 1) {
        // For the first and last color rectangles, draw a rounded rectangle
        final rrect = RRect.fromRectAndCorners(
          sectionRect,
          topLeft: i == 0 ? borderRadius.topLeft : Radius.zero,
          topRight:
              i == colors.length - 1 ? borderRadius.topRight : Radius.zero,
          bottomLeft: i == 0 ? borderRadius.bottomLeft : Radius.zero,
          bottomRight:
              i == colors.length - 1 ? borderRadius.bottomRight : Radius.zero,
        );
        canvas.drawRRect(rrect, paint);
      } else {
        // For all other color rectangles, draw a regular rectangle
        canvas.drawRect(sectionRect, paint);
      }

      // Draw the tick mark under the selected color section
      for (var selectedValue in selectedValues) {
    final selectedSection =
        ((selectedValue == 1.0 ? selectedValue - 0.001 : selectedValue) *
                colors.length)
            .floor();
    if (i == selectedSection && isSimilarColor(selectedColor, colors[i])) {
          final tickMarkPath = Path();
          tickMarkPath.moveTo(sectionWidth * i + 10, size.height / 2 - 5);
          tickMarkPath.lineTo(
              sectionWidth * i + sectionWidth / 4, size.height / 2 + 5);
          tickMarkPath.lineTo(
              sectionWidth * (i + 1) - 10, size.height / 2 - 10);
          final tickMarkPaint = Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0;
          canvas.drawPath(tickMarkPath, tickMarkPaint);
        }
      }

      // Draw the number under each color section
      final textSpan = TextSpan(
        text: '${i + 1}',
        style: TextStyle(color: Colors.black, fontSize: 14.0),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: sectionWidth,
      );
      final offset = Offset(
          sectionWidth * i + sectionWidth / 2 - textPainter.width / 2,
          size.height + 5);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
