import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_style/style.dart';

class WaveShape extends StatelessWidget {
  const WaveShape({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 30.h,
      child: CustomPaint(painter: _WavePainter()),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppStyle.primaryColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height); // start bottom-left

    // First curve: rise to peak near top-left
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.05,
      // control point (pulls up very high)
      size.width * 0.4,
      size.height * 0.3, // end point (coming down)
    );

    // Second curve: slope down toward the ground on the right
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.6, // control point
      size.width,
      size.height, // end point → bottom-right corner
    );

    path.lineTo(size.width, size.height); // ensure bottom edge
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
