import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  final bool isHaveSubCategory;
  CurvedPainter({
    required this.isHaveSubCategory,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = isHaveSubCategory
          ? Colors.blueAccent.withOpacity(0.09)
          : Colors.purpleAccent.withOpacity(0.09)
      ..strokeWidth = 32;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.5, size.width * 1.0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.7, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
