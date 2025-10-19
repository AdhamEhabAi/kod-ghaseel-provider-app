import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../Utilites/app_fonts/font.dart';


class SmallStatCard extends StatelessWidget {
  final String title;
  final String value;

  const SmallStatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      height: MediaQuery.of(context).size.height*(70/844),
      width: MediaQuery.of(context).size.width*(112/390),
      decoration: BoxDecoration(
        border: Border.all(color:Color.fromRGBO(25, 33, 38, 0.1)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),

      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                softWrap: false,
                title,
                style: AppTextStyle.blackW500Size13.copyWith(color: Color.fromRGBO(25, 33, 38, 0.5))
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    value,
                    style: AppTextStyle.blackW700Size26
                ),
                SizedBox(width: 5.w,),
                Text(
                    s.currency_sar,
                  style: AppTextStyle.blackW600Size14Roboto
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
