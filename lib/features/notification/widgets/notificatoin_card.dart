import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Utilites/app_assets/assets.dart';
import '../../../Utilites/app_fonts/font.dart';
import '../../../Utilites/app_style/style.dart';
import '../../../generated/l10n.dart';
import '../controller/notification_cubit.dart';
import '../data/models/get_all_notification_response.dart'; // ✅ Localization import

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.isSelectedRead,
  });

  final NotificationItem notification;
  final bool isSelectedRead;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ Localization instance
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: isSelectedRead
                        ? AppTextStyle.blackW600Size16Roboto
                        : AppTextStyle.blackW600Size16Roboto.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    notification.description,
                    style: isSelectedRead
                        ? TextStyle(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff808080),
                      fontFamily: "Cairo",
                    )
                        : TextStyle(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff808080),
                      fontFamily: "Cairo",
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 0) {
                  context.read<NotificationCubit>().markAsRead(
                    notificationId: notification.id,
                  );
                } else if (value == 1) {
                  context.read<NotificationCubit>().deleteNotification(
                    notificationId: notification.id,
                  );
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: Colors.white,
              offset: const Offset(0, 25),
              itemBuilder: (context) => isSelectedRead
                  ? [
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
              ]
                  : [
                PopupMenuItem(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  value: 0,
                  child: Row(
                    children: [
                      SizedBox(width: 16.w),
                      SvgPicture.asset(
                        Assets.visibleIconSVG,
                        color: Colors.black,
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        s.markAsRead,
                        style: AppTextStyle.blackBoldSize14,
                      ),
                      SizedBox(width: 50.w),
                    ],
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
