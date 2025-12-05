import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/dialog_utils.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/availability_pill_switch.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/show_unavailable_duration_dialog.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../data/models/CheckSessionValidationResponse.dart'; // <— localization

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key, this.isFilterIconExists = false});

  final bool isFilterIconExists;

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  final TextEditingController controller = TextEditingController();
  Timer? _autoEnableTimer; // auto re-enable timer

  @override
  void dispose() {
    _autoEnableTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _scheduleAutoEnable(DateTime offlineUntil) {
    _autoEnableTimer?.cancel();
    final now = DateTime.now();
    if (offlineUntil.isBefore(now)) return;

    final dur = offlineUntil.difference(now);
    _autoEnableTimer = Timer(dur, () {
      if (!mounted) return;
      // Refresh status from API
      context.read<HomeScreenCubit>().getProviderStatus();
      ToastM.show(S
          .of(context)
          .autoEnabledSnackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocSelector<HomeScreenCubit, HomeScreenState, UserData?>(
      selector: (state) {
        if (state is UserDataLoaded) {
          return state.userDara;
        } else {
          return null;
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeScreenCubit>();
        final cachedUser = cubit.userData;
        final imagePath = cachedUser?.profileImage;
        final fullName = cachedUser?.fullName;
        final isLoading = cachedUser == null;
        return Skeletonizer(
          enabled: isLoading,
          child: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                    builder:(context) {
                      final double size = 40.w;
                      final hasImage = imagePath != null && imagePath.isNotEmpty;
                      final isNetwork = hasImage && imagePath.startsWith('http');
                      final isLocal = hasImage && File(imagePath).existsSync();
                      if (isNetwork) {
                        return ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(50.r),
                          child: CachedNetworkImage(
                            imageUrl: imagePath,
                            width: size,
                            height: size,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: AppLoader(),
                              ),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 24.sp)),
                              ),
                            ),
                          ),
                        );
                      }

                      // LOCAL FILE IMAGE
                      if (isLocal) {
                        return ClipOval(
                          child: Image.file(
                            File(imagePath),
                            width: size,
                            height: size,
                            fit: BoxFit.cover,
                          ),
                        );
                      }

                      // DEFAULT AVATAR
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 24.sp)),
                        ),
                      );
                    },
                ),

                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s.helloName(fullName??"NAN"),
                        style: AppTextStyle.whiteW500Size16),
                    Row(
                      children: [
                        SvgPicture.asset(
                            Assets.trophyIconSVG, color: Colors.white),
                        Text(s.roleDelegate,
                            style: AppTextStyle.whiteW500Size10),
                      ],
                    ),
                  ],
                ),
                const Spacer(),

                if (widget.isFilterIconExists)
                  GestureDetector(
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.filterHomeScreen),
                    child: SvgPicture.asset(Assets.filterIconSVG),
                  )
                else
                  BlocConsumer<HomeScreenCubit, HomeScreenState>(
                    listener: (context, state) {
                      if (state is ProviderStatusLoading) {
                        DialogUtils.showLoading(
                          context: context,
                          message:
                          s.status_availableNow,
                        );
                      } else if (state is ProviderStatusError) {
                        DialogUtils.hideLoading(context);
                      } else if (state is ProviderStatusLoaded) {
                        DialogUtils.hideLoading(context);
                        final status = state.response.data;
                        if (status != null && status.isOffline) {
                          final offlineUntil = status.offlineUntilDateTime;
                          if (offlineUntil != null) {
                            _scheduleAutoEnable(offlineUntil);
                          }
                        } else if (status != null && status.isOnline) {
                          _autoEnableTimer?.cancel();
                        }
                        if (state.response.message != null &&
                            state.response.message!.isNotEmpty) {
                          if (state.response.message != null) {
                            ToastM.show(state.response.message!);
                          }
                        }
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<HomeScreenCubit>();
                      final isAvailable = cubit.isProviderOnline;
                      final isLoading = state is ProviderStatusLoading;

                      return Opacity(
                        opacity: isLoading ? 0.6 : 1.0,
                        child: AbsorbPointer(
                          absorbing: isLoading,
                          child: AvailabilityPillSwitch(
                            value: isAvailable,
                            onBeforeToggle: (nextValue) async {
                              if (nextValue == false) {
                                controller
                                    .clear(); // Clear controller before showing dialog
                                final hours = await showUnavailableDurationDialog(
                                  context,
                                  controller,
                                );
                                if (hours == null)
                                  return false; // user canceled

                                if (hours <= 0) {
                                  ToastM.show(s.invalidHoursMsg);
                                  return false;
                                }

                                // Call API to set offline
                                await cubit.setProviderOffline(hours: hours);
                                return true; // proceed OFF
                              }

                              // Call API to set online - user can go online anytime
                              await cubit.setProviderOnline();
                              return true; // allow ON
                            },
                            onChanged: (isOn) {
                              // This is handled by the API calls in onBeforeToggle
                              // The state will update via BlocConsumer
                            },
                          ),
                        ),
                      );
                    },
                  ),

                SizedBox(width: 20.w),
                badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -5, end: 11),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(5),
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.chatScreen),
                    child: SvgPicture.asset(Assets.notificationIcon),
                  ),
                ),
                SizedBox(width: 15.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
