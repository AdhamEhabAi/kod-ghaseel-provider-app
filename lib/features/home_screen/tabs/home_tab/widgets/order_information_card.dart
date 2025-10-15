import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
    required this.serviceDescription,
    required this.clientName
  });

  final String clientName;
  final String serviceDescription;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        // GoRouter.of(context).push();

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: Color(0xffEAECF0), width: 0.98),
          color: Color(0xffF9FAFB),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(clientName, style: AppTextStyle.blackW500Size14),
                Spacer(),

                SizedBox(width: 6.w),
                SvgPicture.asset(Assets.lightningIconSVG, height: 25.sp),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              radius: BorderRadius.circular(29.3.r),
              thickness: 4.h,
              color: Color(0xffE7E7E7),
              endIndent: 3.w,
              indent: 3.w,
            ),
            SizedBox(height: 11.7.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(98.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.calenderScreenIconSVG,
                        height: 20.h,
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          serviceDescription,
                          style: AppTextStyle.blackW500Size10,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(98.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                  child: Row(
                    children: [
                      Text(
                        "عرض",
                        style: AppTextStyle.blackW700Size14Roboto.copyWith(
                            fontFamily: "Inter"),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.h,
                        color: AppStyle.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
