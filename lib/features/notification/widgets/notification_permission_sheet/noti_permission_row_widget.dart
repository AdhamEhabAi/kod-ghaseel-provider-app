import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utilites/app_style/style.dart';

class BottomSheetRowWidget extends StatelessWidget {
  final String text;
  final String emoji;
  const BottomSheetRowWidget(this.text, this.emoji, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              text,
              style: TextStyle(
                  color: Color(0xff808080),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppStyle.cairoFont
              )
          ),
          Text(emoji, style:TextStyle(fontSize: 18)),

        ],
      ),
    );
  }
}
