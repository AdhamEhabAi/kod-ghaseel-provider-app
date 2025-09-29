import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../Utilites/app_fonts/font.dart';
import '../../../../Utilites/app_style/style.dart';
import '../../widgets/home_sliver_app_bar.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
