import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import 'order_card_data.dart';
import 'order_card_title.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, this.isOrder = true});

  final bool isOrder;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.only(left: 24.w, right: 8.w, top: 14.h, bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffEAECF0)),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isOrder
              ? OrderCardTitle(value: "#KG20250817001", title: s.order_number)
              : OrderCardTitle(value: s.package_silver, title: s.package),
          SizedBox(height: 10.h),
          isOrder
              ? const SizedBox.shrink()
              : OrderCardData(field: s.washes_count, value: "2/4"),

          OrderCardData(field: s.date_label, value: "02/8/2025"),
          SizedBox(height: 6.h),
          OrderCardData(field: s.time_label, value: "10:00 AM"),
          SizedBox(height: 6.h),
          OrderCardData(field: s.service_label, value: s.service_inside_out),
          SizedBox(height: 6.h),
          OrderCardData(field: s.status_label, value: s.status_in_progress),
        ],
      ),
    );
  }
}
