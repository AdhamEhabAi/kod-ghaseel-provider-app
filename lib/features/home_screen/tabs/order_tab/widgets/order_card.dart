import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'order_card_title.dart';
import 'order_card_data.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, this.isOrder = true});

  final bool isOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.only(left: 24.w, right: 8.w, top: 14.h, bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffEAECF0)),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isOrder
              ? OrderCardTitle(value: "#KG20250817001", title: "رقم الطلب")
              : OrderCardTitle(value: "الفضية", title: "الباقة"),
          SizedBox(height: 10.h),
          isOrder
              ? SizedBox.shrink()
              : OrderCardData(field: "عدد الغسلات", value: "2/4"),

          OrderCardData(field: "التاريخ", value: "02/8/2025"),
          SizedBox(height: 6.h),
          OrderCardData(field: "الوقت", value: "10:00 AM"),
          SizedBox(height: 6.h),
          OrderCardData(field: "الخدمة", value: "غسيل خارجي وداخلي"),
          SizedBox(height: 6.h),
          OrderCardData(field: "الحالة", value: "قيد التنفيذ"),
        ],
      ),
    );
  }
}
