import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_assets/assets.dart';
import '../tabs/home_tab/widgets/top_bar_widget.dart';


class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 300.h,
      toolbarHeight: 110.h,
      floating: true,
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(Assets.homeBG, fit: BoxFit.cover),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Container(
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                      child: const TopBarWidget(),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F4F5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.r),
                      topLeft: Radius.circular(24.r),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
