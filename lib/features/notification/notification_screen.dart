import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_back_button.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_filter_button.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/notification_permission_sheet/show_notification_permission.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/notificatoin_card.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Utilites/app_fonts/font.dart';
import '../../core/router/router.dart';
import '../../shared/shared_widget.dart';
import 'data/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      if (!mounted) return;
      if (!(await Permission.notification.isGranted)) {
        showNotificationPermission(context);
      }
    });
  }

  final TextEditingController searchController = TextEditingController();

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "🚗 غسيل سيارتك بدأ!",
      subtitle: "المندوب في الطريق.",
      createdAt: DateTime.now().subtract(const Duration(hours: 1)), // اليوم
    ),
    NotificationModel(
      title: "✨ سيارتك صارت جديدة!",
      subtitle: "تم إنهاء طلبك.",
      createdAt: DateTime.now().subtract(const Duration(hours: 3)), // اليوم
    ),
    NotificationModel(
      title: "⏰ لا تنسَ سيارتك!",
      subtitle: "احجز غسيلك القادم.",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)), // أمس
    ),
    NotificationModel(
      title: "💦 طلبك قيد التنفيذ",
      subtitle: "جاري غسيل السيارة.",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 4)), // أمس
    ),
    NotificationModel(
      title: "🕒 المندوب وصل!",
      subtitle: "سيارتك بتتغسل الآن.",
      createdAt: DateTime.now().subtract(const Duration(days: 10)), // منذ 10 أيام
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => GoRouter.of(context).push(AppRouter.filterScreen),
                    child: const CustomFilterButton(),
                  ),
                  const Spacer(),
                  const CustomBackButton(),
                ],
              ),
              SizedBox(height: 25.h),

              // ✅ Localized title
              Text(
                s.notificationsTitle,
                style: AppTextStyle.blackW600Size28Roboto,
              ),
              SizedBox(height: 12.h),

              // ✅ Localized search field
              CustomTextFormField(
                textDirection: TextDirection.rtl,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: s.searchNotifications,
                hintTextDirection: TextDirection.rtl,
                colorBorder: const Color(0xffEEEEEE),
                color: Colors.transparent,
                controller: searchController,
              ),
              SizedBox(height: 33.5.h),

              // ✅ Notifications list
              Expanded(
                child: GroupedListView<NotificationModel, int>(
                  elements: notifications,
                  groupBy: (n) => n.daysBetween,
                  order: GroupedListOrder.ASC,
                  groupSeparatorBuilder: (diff) => Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 8.w,
                      top: 8.h,
                      bottom: 8.h,
                    ),
                    child: Text(
                      NotificationModel.localizedRelativeLabel(context, diff), // ✅ Localized helper
                      style: TextStyle(
                        color: const Color(0xff808080),
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  itemBuilder: (context, n) => NotificationCard(notification: n),
                  separator: SizedBox(height: 15.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
