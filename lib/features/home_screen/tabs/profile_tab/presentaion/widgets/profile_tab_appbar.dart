import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Utilites/app_style/style.dart';
import '../../../home_tab_controller.dart';
import 'show_exit_dialog.dart';


class ProfileTabAppBar extends StatelessWidget {
  const ProfileTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showExitDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppStyle.red, width: .5),
                  ),
                  child: Center(
                    child: Icon(Icons.logout, color: AppStyle.red, size: 30.w),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: InkWell(
              onTap: (){
                HomeTabController.value.value = 0;
              },
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: AppStyle.primaryColor,
                child: Icon(Icons.arrow_forward, color: Colors.white, size: 30.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

