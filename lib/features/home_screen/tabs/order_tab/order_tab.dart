import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/widgets/order_card.dart';

import '../../../../Utilites/app_assets/assets.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.bottomLeft,
            end: AlignmentGeometry.topRight,
            colors: [Color(0xFF009CBF), Color(0xFF017D98), Color(0xFF01D0FE)],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 21.h),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("الطلبات",style: AppTextStyle.whiteW800Size24Roboto,),
                          Text("الطلبات الحالية والسابقة",style: AppTextStyle.whiteW600Size14Roboto,),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: AppStyle.primaryColor,
                        child: SvgPicture.asset(Assets.filterIconSVG,width: 17.w,height: 16.h,),
                      ),
                      SizedBox(width: 12.w,),
                      Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xffFCFCFE),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r),topLeft: Radius.circular(30.r)),
                  ),
                  child: Column(
                    children: [
                      OrderCard(),
                      OrderCard(),
                      OrderCard(),
                      OrderCard(),
                      OrderCard(),
                      OrderCard(),
                      OrderCard(),
                      SafeArea(child: SizedBox.shrink())
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}

