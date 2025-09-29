import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Utilites/app_assets/assets.dart';

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 18.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff01D0FE),
      ),
      child: SvgPicture.asset(Assets.filterIconSVG, height: 25.h, width: 27.w),
    );
  }
}
