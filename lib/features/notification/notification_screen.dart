import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_back_button.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_filter_button.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/notificatoin_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../core/router/router.dart';
import '../../core/widgets/toast_m.dart';
import '../../generated/l10n.dart';
import '../../shared/shared_widget.dart';
import 'controller/notification_cubit.dart';
import 'controller/notification_state.dart';
import 'data/models/get_all_notification_response.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotification();
  }

  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.filterScreen);
                      },
                      child: const CustomFilterButton(),
                    ),
                    const Spacer(),
                    InkWell(
                      // to make the list empty so the skeletonizer works
                        onTap: () => context.read<NotificationCubit>().notificationList=[],
                        child: CustomBackButton()),
                  ],
                ),
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
                textDirection: TextDirection.ltr,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: s.searchNotifications,
                hintTextDirection: TextDirection.ltr,
                colorBorder: const Color(0xffEEEEEE),
                color: Colors.transparent,
                controller: searchController,
              ),
              SizedBox(height: 33.5.h),

              BlocConsumer<NotificationCubit,NotificationStates>(
                listener: (context, state) {
                  if(state is DeleteNotificationSuccessState){
                    ToastM.show(state.message);
                  }
                },
                builder: (context, state) {
                  bool isLoading=state is GetNotificationLoadingState;
                  if(state is GetNotificationErrorState){
                    return SizedBox.shrink();
                  }
                  return Expanded(
                    child: CustomMaterialIndicator(
                      onRefresh: () =>  context.read<NotificationCubit>().getNotification(),
                      indicatorBuilder: (context, controller) => AppLoader(),
                      backgroundColor: Colors.white,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: GroupedListView<NotificationItem, int>(
                          physics: AlwaysScrollableScrollPhysics(),
                          elements: context.read<NotificationCubit>().notificationList,
                          groupBy: (n) => n.daysBetween,
                          order: GroupedListOrder.ASC,
                          groupSeparatorBuilder: (diff) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: 8.w,
                                top: 8.h,
                                bottom: 8.h,
                              ),
                              child: Text(
                                s.daysAgo(diff),
                                style: TextStyle(
                                  color: const Color(0xff808080),
                                  fontSize: 13.sp,
                                ),
                              ),
                            );
                          },
                          itemBuilder: (context, n) =>
                              NotificationCard(notification: n,isSelectedRead: n.isRead ==1?true:false,),
                          separator: SizedBox(height: 15.h),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

