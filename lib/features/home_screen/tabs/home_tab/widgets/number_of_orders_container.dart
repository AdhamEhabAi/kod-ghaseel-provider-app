import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class NumberOfOrdersContainer extends StatelessWidget {
  const NumberOfOrdersContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      width: size.width*(156/390),
      height: 156.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius:BorderRadius.circular(19.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  softWrap: true,
                  "عدد الطلبات حتى الان",style: AppTextStyle.blackW500Size14,),
              ),
              SvgPicture.asset(Assets.boltIcon),
            ],
          ),
          SizedBox(height: 10.h,),
          RichText(text: TextSpan(
              children: [
                TextSpan(
                  text: "125",
                  style: AppTextStyle.blackW600Size24Roboto,
                ),
                TextSpan(
                    text: "طلب",
                    style: AppTextStyle.blackW400Size11Opacity40
                )
              ]
          )),
          Row(
            children: [
              SvgPicture.asset(Assets.uploadIcon),
              SizedBox(width: 7.w,),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: "10",
                          style: AppTextStyle.blackW600Size16Roboto,
                        ),
                        TextSpan(
                            text: "طلبات يومية",
                            style: AppTextStyle.blackW400Size11Opacity40
                        )
                      ]
                  )),
            ],
          )
        ],
      ),
    );
  }
}
