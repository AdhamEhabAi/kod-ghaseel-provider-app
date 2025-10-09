import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/home_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/order_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/order_tab.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 int currentIndex=0;
final List<Widget> content=[
  HomeTab(),
  OrderTab(),
  ReportTab(),
  ProfileTab(),
];
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom:12.h,left: 15.w,right: 15.w),
        child: ClipRRect(
          borderRadius:BorderRadius.circular(32.r) ,
          child: SalomonBottomBar(
            selectedItemColor: AppStyle.primaryColor,
            itemPadding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 8.h),
            selectedColorOpacity: 1,
            backgroundColor: AppStyle.bottomNavBarColor,
            currentIndex: currentIndex,
            margin: EdgeInsets.symmetric(vertical: 14.h,horizontal: 15),
            onTap: (value) {
              setState(() {
                currentIndex=value;
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: SvgPicture.asset(Assets.homeIconSVG,color: currentIndex ==0 ?AppStyle.bottomNavBarColor:Colors.white,),
                title: Text("الرئيسية",style: TextStyle(color: AppStyle.black),),
              ),
              SalomonBottomBarItem(
                icon:  SvgPicture.asset(Assets.paperIconSVG,color: currentIndex ==1 ?AppStyle.bottomNavBarColor:Colors.white,),
                title: Text("الطلبات",style:TextStyle(color: AppStyle.black),),
              ),
              SalomonBottomBarItem(
                icon:  SvgPicture.asset(Assets.activityIcon,color: currentIndex ==2 ?AppStyle.bottomNavBarColor:Colors.white,),
                title: Text("التقارير",style: TextStyle(color: AppStyle.black),),
              ),
              SalomonBottomBarItem(
                icon:  SvgPicture.asset(Assets.profileIconSVG,color: currentIndex ==3 ?AppStyle.bottomNavBarColor:Colors.white,),
                title: Text("ملفي",style: TextStyle(color: AppStyle.black),),
              ),
            ],

          ),
        ),
      ),
      body:content[currentIndex] ,
    );
  }
}
