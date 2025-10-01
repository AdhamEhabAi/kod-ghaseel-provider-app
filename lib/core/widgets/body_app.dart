import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';

class BodyApp extends StatelessWidget {
  const BodyApp({super.key, required this.title, required this.content});
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF009CBF),
                  Color(0xFF017D98),
                  Color(0xFF01D0FE),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 20.w,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        GoRouter.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                  SizedBox(width: 10.w),
                  Text(title, style: AppTextStyle.whiteW700Size20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 120.h,
            child: Container(
              width: size.width,
              height: size.height - 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: content,
            ),

          ),
        ],
      ),
    );
  }
}