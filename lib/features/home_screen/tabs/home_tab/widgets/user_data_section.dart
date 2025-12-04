import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import '../../../../../core/router/router.dart';
import '../../../../../generated/l10n.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({
    super.key,
    required this.name,
    required this.subtitle,
    this.phoneNumber,
  });
  final String name;
  final String subtitle;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppStyle.primaryColorOpacity52,
          radius: 24.r,
          child: Text('🧑🏻‍🦱',style: TextStyle(fontSize: 20.sp),),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyle.blackW600Size16Roboto,
              ),
              Text(
                subtitle,
                style: AppTextStyle.greyTextW600Size12.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(Assets.messageIcon),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.chatScreen);
          },
        ),
        IconButton(
          icon: SvgPicture.asset(Assets.phoneIcon),
          onPressed: () async {
            if (phoneNumber != null && phoneNumber!.isNotEmpty) {
              // Clean phone number (remove spaces, dashes, etc.)
              final cleanPhoneNumber = phoneNumber!.replaceAll(RegExp(r'[\s\-\(\)]'), '');
              final uri = Uri.parse('tel:$cleanPhoneNumber');
              try {
                // Directly launch the phone dialer without checking canLaunchUrl
                // as it may return false even when dialer is available
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                if (context.mounted) {
                  ToastM.show('${s.errorCalling}: ${e.toString()}');
                }
              }
            } else {
              // Show message if no phone number available
              if (context.mounted) {
                ToastM.show(s.phoneNumberNotAvailable);
              }
            }
          },
        ),
      ],
    );
  }
}
