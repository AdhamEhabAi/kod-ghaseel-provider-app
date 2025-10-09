import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';

import 'order_card_data.dart';
import 'order_card_title.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.only(
        left: 17.w,
        right: 17.w,
        top: 14.h,
        bottom: 14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderCardTitle(value: "#KG20250817001", title: "رقم الطلب"),
          OrderCardData(field: "اسم العميل", value: "احمد محمد"),
          OrderCardData(field: "التاريخ", value: "02/8/2025"),
          OrderCardData(field: "الوقت", value: "10:00 AM"),
          OrderCardData(field: "الخدمة", value: "غسيل خارجي وداخلي"),
          OrderCardData(field: "تكلفة الخدمة", value: "25 ريال"),
          OrderCardData(field: "الحالة", value: "قيد التنفيذ"),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
              backgroundColor: AppStyle.primaryColorOpacity10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(99.r))
            ),
            onPressed: () {
            // Todo: navigate to order details screen
            },
            child: Text("عرض التفاصيل", style: AppTextStyle.primaryW600Size16),
          ),
        ],
      ),
    );
  }
}
