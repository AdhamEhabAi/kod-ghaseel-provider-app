import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../Utilites/app_fonts/font.dart';

class ServiceScreenAppBar extends StatelessWidget {
  const ServiceScreenAppBar({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 16.w,
      right: 16.w,
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: .2,color: Colors.grey),
                    borderRadius: BorderRadius.circular(7.r)
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: AppTextStyle.blackW500Size16.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: .2,color: Colors.grey),
                    borderRadius: BorderRadius.circular(7.r)
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
