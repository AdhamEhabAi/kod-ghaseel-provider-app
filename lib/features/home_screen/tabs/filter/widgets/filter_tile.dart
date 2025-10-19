import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTile extends StatelessWidget {
  const FilterTile({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedBg,
    required this.primary,
    required this.borderGrey,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedBg;
  final Color primary;
  final Color borderGrey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 58.h,
        decoration: BoxDecoration(
          color: selected ? selectedBg : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: selected ? primary : borderGrey, width: 1),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // Square checkbox at the RIGHT
            Container(
              width: 26.w,
              height: 26.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: Colors.black87, width: 1.6.w),
                color: selected ? Colors.black : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: selected
                  ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                  : null,
            ),
            SizedBox(width: 8.w),

            // Text immediately next to checkbox
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 14.sp,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
