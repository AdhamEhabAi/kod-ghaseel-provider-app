import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:intl/intl.dart';

class ServiceStepsRows extends StatelessWidget {
  final int currentStep;
  final DateTime? arrivalTime;
  final Duration washingElapsedTime;
  final Duration dryingElapsedTime;
  final bool isWashingTimerRunning;
  final bool isDryingTimerRunning;
  final Duration? finalWashingDuration; // Final duration when washing is completed
  final Duration? finalDryingDuration; // Final duration when drying is completed

  const ServiceStepsRows({
    super.key,
    required this.currentStep,
    this.arrivalTime,
    required this.washingElapsedTime,
    required this.dryingElapsedTime,
    required this.isWashingTimerRunning,
    required this.isDryingTimerRunning,
    this.finalWashingDuration,
    this.finalDryingDuration,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Format arrival time
    String arrivalTimeStr = '';
    if (arrivalTime != null) {
      arrivalTimeStr = DateFormat('HH:mm').format(arrivalTime!);
    }

    // Determine step statuses based on currentStep
    String getStepStatus(int index) {
      if (index < currentStep) return 'done';
      if (index == currentStep) return 'active';
      return 'pending';
    }

    // Get step subtitle based on status and current step
    String getStepSubtitle(int index) {
      if (index == 0) {
        // Arrival step - show arrival time
        return arrivalTimeStr.isNotEmpty ? arrivalTimeStr : '';
      } else if (index == 2) {
        // Washing step
        if (isWashingTimerRunning) {
          // Show live timer when running
          final minutes = washingElapsedTime.inMinutes;
          final seconds = washingElapsedTime.inSeconds.remainder(60);
          return '$minutes:${seconds.toString().padLeft(2, '0')}';
        } else if (currentStep > 2 && finalWashingDuration != null) {
          // Show final duration when step is completed
          final minutes = finalWashingDuration!.inMinutes;
          final seconds = finalWashingDuration!.inSeconds.remainder(60);
          return '$minutes:${seconds.toString().padLeft(2, '0')}';
        }
        return '';
      } else if (index == 3) {
        // Drying step
        if (isDryingTimerRunning) {
          // Show live timer when running
          final minutes = dryingElapsedTime.inMinutes;
          final seconds = dryingElapsedTime.inSeconds.remainder(60);
          return '$minutes:${seconds.toString().padLeft(2, '0')}';
        } else if (currentStep > 3 && finalDryingDuration != null) {
          // Show final duration when step is completed
          final minutes = finalDryingDuration!.inMinutes;
          final seconds = finalDryingDuration!.inSeconds.remainder(60);
          return '$minutes:${seconds.toString().padLeft(2, '0')}';
        }
        return '';
      }
      return '';
    }

    final steps = <Map<String, dynamic>>[
      {
        'title': s.step_arrival,
        'subtitle': getStepSubtitle(0),
        'status': getStepStatus(0),
        'icon': Icons.location_on,
      },
      {
        'title': s.step_checkCar,
        'subtitle': getStepSubtitle(1),
        'status': getStepStatus(1),
        'icon': Icons.car_repair,
      },
      {
        'title': s.step_startWashing,
        'subtitle': getStepSubtitle(2),
        'status': getStepStatus(2),
        'icon': Icons.water_drop,
      },
      {
        'title': s.step_drying,
        'subtitle': getStepSubtitle(3),
        'status': getStepStatus(3),
        'icon': Icons.air,
      },
      {
        'title': s.step_finishService,
        'subtitle': getStepSubtitle(4),
        'status': getStepStatus(4),
        'icon': Icons.check_circle,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: steps.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final step = steps[index];
        final status = step['status']!;
        final isFirst = index == 0;
        final isLast = index == steps.length - 1;

        if (status == 'active') {
          final icon = step['icon'] as IconData? ?? Icons.radio_button_checked;

          return Container(
            padding: EdgeInsetsDirectional.only(
              end: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: AppStyle.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: AppStyle.primaryColor,
                      size: 30.w,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'] ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.blackW600Size16Roboto
                            .copyWith(fontSize: 17.sp),
                      ),
                      if ((step['subtitle'] ?? '').toString().isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            step['subtitle'].toString(),
                            textAlign: TextAlign.center,
                            style: AppTextStyle.greyW600Size12Roboto.copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildRowIcon(
              status,
              step['icon'] as IconData?,
              showTop: !isFirst,
              showBottom: !isLast,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] ?? '',
                    style: AppTextStyle.greyW600Size12Roboto.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  if ((step['subtitle'] ?? '').isNotEmpty)
                    Text(
                      step['subtitle']!,
                      style: AppTextStyle.greyW600Size12Roboto.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: status == 'done'
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRowIcon(
    String status,
    IconData? icon, {
    bool showTop = true,
    bool showBottom = true,
  }) {
    switch (status) {
      case 'done':
        return Column(
          children: [
            if (showTop)
              Container(width: 2.w, height: 20.h, color: AppStyle.primaryColor),
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppStyle.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.check,
                color: Colors.white,
                size: 30.w,
              ),
            ),
            if (showBottom)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
          ],
        );
      case 'pending':
      default:
        return Column(
          children: [
            if (showTop)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFBDBDBD), width: 2.w),
              ),
              child: Icon(
                icon ?? Icons.radio_button_unchecked,
                size: 30.sp,
                color: Colors.grey.shade400,
              ),
            ),
            if (showBottom)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
          ],
        );
    }
  }
}
