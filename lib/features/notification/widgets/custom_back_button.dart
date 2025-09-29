import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 18.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff01D0FE),
        ),
        child: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 33),
      ),
    );
  }
}
