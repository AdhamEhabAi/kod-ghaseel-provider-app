import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/controller/profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/app_loader.dart';
import '../../../../../../core/widgets/toast_m.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../controller/home_screen_cubit.dart';

Future<void> showSupportContactDialog(BuildContext context) async {
  final s = S.of(context);
  final profileCubit = context.read<ProfileCubit>();

  if (profileCubit.contactInfo == null) {
    await profileCubit.getContactInfo();
  }

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is ContactInfoLoadingState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppLoader(),
                    SizedBox(height: 16.h),
                    Text(
                      s.loading,
                      style: AppTextStyle.blackW600Size14Roboto,
                    ),
                  ],
                ),
              ),
            );
          }

          final contactInfo = profileCubit.contactInfo;
          if (contactInfo == null) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Text(
                s.support,
                style: AppTextStyle.blackW600Size18Roboto,
              ),
              content: Text(
                s.unableToLoadContactInfo,
                style: AppTextStyle.blackW400Size14Roboto,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    s.close,
                    style: AppTextStyle.blackW600Size14Roboto,
                  ),
                ),
                if (state is ContactInfoErrorState)
                  TextButton(
                    onPressed: () async {
                      await profileCubit.getContactInfo();
                      // The BlocBuilder will rebuild automatically
                    },
                    child: Text(
                      s.retry,
                      style: AppTextStyle.blackW600Size14Roboto.copyWith(
                        color: AppStyle.primaryColor,
                      ),
                    ),
                  ),
              ],
            );
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s.support,
                          style: AppTextStyle.blackW600Size18Roboto,
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 24.sp),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      s.needHelp,
                      style: AppTextStyle.blackW600Size14Roboto,
                    ),
                    SizedBox(height: 20.h),
                    if (contactInfo.phone.isNotEmpty) ...[
                      _ContactItem(
                        icon: Icons.phone,
                        label: s.phoneNumber,
                        value: contactInfo.phone,
                        onTap: () => _makePhoneCall(context, contactInfo.phone),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (contactInfo.whatsapp.isNotEmpty) ...[
                      _ContactItem(
                        icon: Icons.chat,
                        label: s.whatsapp,
                        value: contactInfo.whatsapp,
                        onTap: () => _openWhatsApp(context, contactInfo.whatsapp),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (contactInfo.email.isNotEmpty) ...[
                      _ContactItem(
                        icon: Icons.email,
                        label: s.emailAddress,
                        value: contactInfo.email,
                        onTap: () => _sendEmail(context, contactInfo.email),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (contactInfo.address.isNotEmpty) ...[
                      _ContactItem(
                        icon: Icons.location_on,
                        label: s.addressLabel,
                        value: contactInfo.address,
                        onTap: null,
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppStyle.primaryColor, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.greyW300Size12,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: AppTextStyle.blackW600Size14Roboto,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
  try {
    // Clean phone number (remove spaces, dashes, etc.)
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[\s-()]'), '');
    final uri = Uri.parse('tel:$cleanPhoneNumber');
    // Directly launch without checking canLaunchUrl to avoid channel errors
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Error launching phone call: $e');
    // Show user-friendly error message
    if (context.mounted) {
      final s = S.of(context);
      ToastM.show(s.unableToMakePhoneCall);
    }
  }
}

Future<void> _openWhatsApp(BuildContext context, String phoneNumber) async {
  try {
    // Clean phone number (remove spaces, dashes, etc.)
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[\s-()]'), '');
    // Remove leading + if present for WhatsApp
    final whatsappNumber = cleanPhoneNumber.startsWith('+')
        ? cleanPhoneNumber.substring(1)
        : cleanPhoneNumber;
    final uri = Uri.parse('https://wa.me/$whatsappNumber');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Error launching WhatsApp: $e');
    if (context.mounted) {
      final s = S.of(context);
      ToastM.show("s.unableToOpenWhatsApp");
    }
  }
}

Future<void> _sendEmail(BuildContext context, String email) async {
  try {
    final uri = Uri.parse('mailto:$email');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Error launching email: $e');
    if (context.mounted) {
      final s = S.of(context);
      ToastM.show(s.unableToSendEmail);
    }
  }
}

