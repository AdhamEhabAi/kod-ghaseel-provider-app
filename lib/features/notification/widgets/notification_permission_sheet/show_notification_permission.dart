import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utilites/app_style/style.dart';
import 'bottom_sheet_notification_permission_content.dart';

void showNotificationPermission(BuildContext context){
  showModalBottomSheet(

    isScrollControlled: true,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.only(
        topRight: Radius.circular(24.r),
        topLeft: Radius.circular(24.r),
      ),
    ),
    backgroundColor: AppStyle.scaffoldBackground,
    context: context,
    builder: (context) {
      return SizedBox(
          height: MediaQuery.of(context).size.height*0.7,
          child: BottomSheetNotificationPermissionContent());
    },
  );
}