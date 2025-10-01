import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/accepting_rate_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/balance_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/number_of_orders_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/order_information_card.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/top_bar_widget.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';

import '../../../../Utilites/app_fonts/font.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.bottomLeft,
            end: AlignmentGeometry.topRight,
            colors: [Color(0xFF009CBF), Color(0xFF017D98), Color(0xFF01D0FE)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              TopBarWidget(),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0.w),
                child: BalanceContainer(),
              ),
              SizedBox(height: 19.h),
              Container(
                padding: EdgeInsets.only(top: 15.h, left: 25.w, right: 25.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberOfOrdersContainer(),
                        AcceptingRateContainer(),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "الطلب الحالي",
                      style: AppTextStyle.blackW700Size18Roboto,
                    ),
                    SizedBox(height:10.h ,),
                    UserDataSection(),
                    SizedBox(height: 12.h,),
                    Row(
                      children: [
                        Text(
                          "طلبات متاحة",
                          style: AppTextStyle.blackW700Size18Roboto,
                        ),
                        Spacer(),
                        Text(
                          "عرض الكل",
                          style: AppTextStyle.primaryW600Size18.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppStyle.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    OrderInformation(clientName: "ساره", serviceDescription: "تويتا كامري - غسيل كامل - 2.5 كم"),
                    SizedBox(height: 16.h,),
                    OrderInformation(clientName: "فاطمة خالد", serviceDescription: "هوندا أكورد - غسيل خارجي - 1.8 كم"),
                    SafeArea(child: SizedBox.shrink())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}