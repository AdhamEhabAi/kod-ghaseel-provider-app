import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/calender_tab/widgets/calender_card.dart';

import '../../widgets/home_sliver_app_bar.dart';

class CalenderTab extends StatelessWidget {
  const CalenderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBar(),

          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xffF2F4F5),
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [


                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
