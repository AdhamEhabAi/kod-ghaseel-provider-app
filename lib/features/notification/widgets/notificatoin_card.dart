import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- added localization

import '../../../Utilites/app_assets/assets.dart';
import '../../../Utilites/app_fonts/font.dart';
import '../../../Utilites/app_style/style.dart';
import '../data/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationModel notification;
  final bool isSelectedRead = false;
  final bool isSelectedDelete = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization instance

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.64.r),
        border: Border.all(color: AppStyle.textFieldBorderColor),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: AppTextStyle.blackW600Size16Roboto,
                ),
                Text(
                  notification.subtitle,
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff808080),
                    fontFamily: "Cairo",
                  ),
                ),
              ],
            ),
            const Spacer(),

            // ⋮ Popup menu
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 0) {
                  // TODO: mark as read
                } else if (value == 1) {
                  // TODO: delete
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: Colors.white,
              offset: const Offset(0, 25),
              itemBuilder: (context) => [
                // ✅ Mark as Read
                PopupMenuItem(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  value: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff01D0FE),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.visibleIconSVG,
                          color: Colors.black,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          s.markAsRead, // ✅ Localized text
                          style: AppTextStyle.blackBoldSize14,
                        ),
                        SizedBox(width: 50.w),
                      ],
                    ),
                  ),
                ),

                // ✅ Delete
                PopupMenuItem(
                  value: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.deleteIconSVG),
                        SizedBox(width: 15.w),
                        Text(
                          s.delete, // ✅ Localized text
                          style: AppTextStyle.blackBoldSize14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
