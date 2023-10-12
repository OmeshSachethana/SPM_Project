import 'package:flutter/material.dart';

class ColorPalette2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 50), // Specify the size of the palette here
      painter: PalettePainter(),
    );
  }
}

class PalettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Color(0xFF23243B),
      Color(0xFF334E62),
      Color(0xFFD5DADF),
      Color(0xFFF1B8C9),
      Color(0xFFF3ACAB),
      Color(0xFF9180C1),
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
