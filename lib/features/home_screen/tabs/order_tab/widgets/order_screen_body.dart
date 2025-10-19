import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'order_card.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // adjust if your path differs

class OrderScreenBody extends StatelessWidget {
  const OrderScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);
    final s = S.of(context); // <-- localization accessor

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(s.orders_title, style: AppTextStyle.blackW600Size14Roboto),
            SizedBox(width: 4.w),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
              decoration: BoxDecoration(
                color: AppStyle.primaryColor.withAlpha(0x1A),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                "4", // keep your count as-is (replace with real value if needed)
                style: AppTextStyle.primaryW600Size12,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AnimatedBuilder(
          animation: tabController,
          builder: (context, _) {
            final index = tabController.index;
            Widget content;
            switch (index) {
              case 0:
                content = Column(
                  children: [
                    SizedBox(height: 8.h),
                    const OrderCard(),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 8.h),
                  ],
                );
                break;

              case 1:
                content = Column(
                  children: [
                    SizedBox(height: 8.h),
                    const OrderCard(),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 8.h),
                  ],
                );
                break;

              default:
                content = Column(
                  children: [
                    SizedBox(height: 8.h),
                    const OrderCard(),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 12.h),
                    const OrderCard(isOrder: false),
                    SizedBox(height: 8.h),
                  ],
                );
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: content,
            );
          },
        ),
      ],
    );
  }
}
