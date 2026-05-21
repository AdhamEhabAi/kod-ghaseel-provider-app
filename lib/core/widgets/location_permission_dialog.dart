import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

/// App Store-compliant pre-permission rationale dialog.
///
/// Shown BEFORE the OS system permission dialog so the user understands
/// exactly why the app needs location access (Apple Guideline 5.1.1).
/// All strings are localised via S.of(context) (AR / EN).
class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog._();

  /// Shows the rationale dialog and returns true when the user taps "Allow".
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LocationPermissionDialog._(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      contentPadding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: const Color(0xFF1565C0),
              size: 36.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            s.locationPermissionDialogTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            s.locationPermissionDialogBody,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: const Color(0xFF555555),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            s.locationPermissionNotNow,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            s.locationPermissionAllow,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

/// Background location rationale — shown just before requesting "Always" access.
/// Must only be shown after "When In Use" is already granted, and only when
/// the provider is about to start an active service job.
/// All strings are localised via S.of(context) (AR / EN).
class BackgroundLocationPermissionDialog extends StatelessWidget {
  const BackgroundLocationPermissionDialog._();

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const BackgroundLocationPermissionDialog._(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      contentPadding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_rounded,
              color: const Color(0xFF2E7D32),
              size: 36.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            s.backgroundLocationDialogTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            s.backgroundLocationDialogBody,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: const Color(0xFF555555),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            s.backgroundLocationSkip,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            s.backgroundLocationAllow,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
