import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';


class TodayOrdersCard extends StatelessWidget {
  const TodayOrdersCard({super.key,required this.done,required this.target});

  final int done,target;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 17.5.w,vertical: 10.h),
      width: size.width*(200/390),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text("طلبات اليوم", style: AppTextStyle.blackW500Size13),
                  SizedBox(height: 10.h),
                  Text(
                    "$done/$target",
                    style: AppTextStyle.blackW600Size16Roboto.copyWith(
                      fontFamily: "Lato",
                    ),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset("assets/icons/shield_icon_primary.svg"),
            ],
          ),
          SizedBox(width: 10.w),
          Directionality(
            textDirection: TextDirection.ltr,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                minHeight: 12.h,
               borderRadius: BorderRadiusGeometry.circular(25.r),
                value: 0.8,
                backgroundColor: AppStyle.primaryColorOpacity10,
                color: AppStyle.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
