import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bullet extends StatelessWidget {
  const Bullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5.r,
          height: 5.r,
          margin: EdgeInsets.only(top: 7.r),
          decoration: BoxDecoration(
            color: const Color(0xFF6E7C86),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF33434C),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
