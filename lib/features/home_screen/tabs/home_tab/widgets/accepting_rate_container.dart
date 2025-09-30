import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class AcceptingRateContainer extends StatelessWidget {
  const AcceptingRateContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      height: 156.h,
      width: size.width*(156/390),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius:BorderRadius.circular(19.r),
      ),
      child: Stack(
        children: [
          Positioned(
              bottom: 11.h,
              child: SvgPicture.asset(Assets.lineBg)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "معدل القبول",style: AppTextStyle.blackW500Size14,),
                  ),
                  // SizedBox(width: 17.w,),
                  SvgPicture.asset(Assets.shieldIcons),
                ],
              ),
              SizedBox(height: 10.h,),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "96%",
                      style: AppTextStyle.blackW600Size24Roboto,
                    ),
                    TextSpan(
                        text: "ممتاز",
                        style: AppTextStyle.blackW400Size11Opacity40
                    )
                  ]
              )),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Icon(Icons.star,color: AppStyle.primaryColor,size: 15.sp),
                  SizedBox(width: 5.w,),
                  Text("4.5",style: AppTextStyle.blackW400Size16Roboto,),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
}
