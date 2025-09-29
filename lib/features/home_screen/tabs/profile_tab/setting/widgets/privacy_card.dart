import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF111111),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFFBFC6CC),
              size: 26.sp,
            ),
          ],
        ),
      ),
    );
  }
}
