import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utilites/app_fonts/font.dart';

class TextFiledTitle extends StatelessWidget {
  final String text;

  const TextFiledTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: AppTextStyle.blackW600Size16Roboto),
    );
  }
}
