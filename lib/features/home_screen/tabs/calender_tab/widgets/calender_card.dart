import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'calendar_card_title.dart';
import 'calender_card_data.dart';

class CalenderCard extends StatelessWidget {
  const CalenderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.only(left: 24.w, right: 8.w, top: 14.h, bottom: 14.h),
      decoration: BoxDecoration(
        color: Color(0xffF9FAFB),
        border: Border.all(color: Color(0xffEAECF0)),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CalenderCardTitle(value: "#KG20250817001", title: "رقم الطلب"),
          SizedBox(height: 10.h),
          CalenderCardData(field: "التاريخ", value: "02/8/2025"),
          SizedBox(height: 6.h),
          CalenderCardData(field: "الوقت", value: "10:00 AM"),
          SizedBox(height: 6.h),
          CalenderCardData(field: "الخدمة", value: "غسيل خارجي وداخلي"),
          SizedBox(height: 6.h),
          CalenderCardData(field: "الحالة", value: "قيد التنفيذ"),
          SizedBox(height: 6.h),
          ElevatedButton(
            onPressed: () {
              // GoRouter.of(context).push(AppRouter.serviceScreen);

            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: AppStyle.primaryColorOpacity10,
            ),
            child: Text("إعادة الطلب", style: AppTextStyle.primaryW600Size16),
          ),
        ],
      ),
    );
  }
}
