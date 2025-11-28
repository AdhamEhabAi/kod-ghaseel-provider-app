import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/availability_pill_switch.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/show_unavailable_duration_dialog.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../core/router/router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <— localization

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key, this.isFilterIconExists = false});

  final bool isFilterIconExists;

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  bool _isAvailable = true;

  DateTime? _unavailableUntil; // when availability should auto-end
  Timer? _autoEnableTimer; // auto re-enable timer

  @override
  void dispose() {
    _autoEnableTimer?.cancel();
    super.dispose();
  }

  void _scheduleAutoEnable(Duration dur) {
    _autoEnableTimer?.cancel();
    _autoEnableTimer = Timer(dur, () {
      if (!mounted) return;
      setState(() {
        _isAvailable = true;
        _unavailableUntil = null;
      });
      // localized feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).autoEnabledSnackbar)),
      );
    });
  }

  bool get _stillUnavailable {
    if (_unavailableUntil == null) return false;
    return DateTime.now().isBefore(_unavailableUntil!);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 43.w,
              height: 43.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 20.sp)),
              ),
            ),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(s.helloName('محمود'), style: AppTextStyle.whiteW500Size16),
                Row(
                  children: [
                    SvgPicture.asset(Assets.trophyIconSVG, color: Colors.white),
                    Text(s.roleDelegate, style: AppTextStyle.whiteW500Size10),
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
              AvailabilityPillSwitch(
                value: _isAvailable,
                onBeforeToggle: (nextValue) async {
                  if (nextValue == false) {
                    final minutes = await showUnavailableDurationDialog(
                      context,
                    );
                    if (minutes == null) return false; // user canceled

                    final dur = Duration(minutes: minutes);
                    final until = DateTime.now().add(dur);
                    setState(() => _unavailableUntil = until);
                    _scheduleAutoEnable(dur);
                    return true; // proceed OFF
                  }

                  // Turning ON while still inside the unavailable window -> block
                  if (_stillUnavailable) {
                    final left = _unavailableUntil!.difference(DateTime.now());
                    final m = left.inMinutes;
                    final sLeft = left.inSeconds % 60;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).cannotEnableYet(m, sLeft)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return false; // veto ON
                  }

                  return true; // allow ON
                },
                onChanged: (isOn) {
                  setState(() => _isAvailable = isOn);
                  if (isOn) {
                    _unavailableUntil = null;
                    _autoEnableTimer?.cancel();
                  }
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
                    GoRouter.of(context).push(AppRouter.notificationScreen),
                child: SvgPicture.asset(Assets.notificationIcon),
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}
