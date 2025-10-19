import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Utilites/app_assets/assets.dart';
import 'noti_permission_row_widget.dart';

class BottomSheetNotificationPermissionContent extends StatelessWidget {
  const BottomSheetNotificationPermissionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 33.h, left: 17.w, right: 17.w, top: 22.h),
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(Assets.notificationPermissionIconSvg),
            SizedBox(height: 18.h),
            Text(
              s.tryMobileWashComfort, // ✅
              textAlign: TextAlign.center,
              style: AppTextStyle.primaryW700Size34,
            ),
            SizedBox(height: 24.h),
            Text(
              s.enableNotificationDescription, // ✅
              textAlign: TextAlign.center,
              style: AppTextStyle.whiteW500Size16.copyWith(color: const Color(0xff808080)),
            ),
            SizedBox(height: 42.h),
            BottomSheetRowWidget(s.exclusiveDiscounts, '💸'),
            BottomSheetRowWidget(s.fastOffersAndAlerts, '🔔'),
            BottomSheetRowWidget(s.carTipsAndSolutions, '✨🚗'),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () async {
                await requestNotificationPermission();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 70.w),
                backgroundColor: AppStyle.primaryColor,
                elevation: 0,
              ),
              child: Text(
                s.enableNotifications, // ✅
                style: AppTextStyle.whiteW600Size16Roboto,
              ),
            ),
            SizedBox(height: 11.h),
            TextButton(
              onPressed: () => GoRouter.of(context).pop(),
              child: Text(
                s.later, // ✅
                style: AppTextStyle.primaryW600Size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Request notification permission
Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    final newStatus = await Permission.notification.request();
    if (newStatus.isGranted) {
      print('Notification permission granted.');
    } else if (newStatus.isDenied) {
      print('Notification permission denied.');
      openAppSettings();
    } else if (newStatus.isPermanentlyDenied) {
      print('Notification permission permanently denied. Open settings to enable.');
      openAppSettings();
    }
  } else if (status.isGranted) {
    print('Notification permission already granted.');
  } else if (status.isPermanentlyDenied) {
    print('Notification permission permanently denied. Open settings to enable.');
    openAppSettings();
  }
}
