import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

Future<int?> showUnavailableDurationDialog(BuildContext context) async {
  final options = <_DurationOption>[
    const _DurationOption('ساعة', 60),
    const _DurationOption('ساعتين', 120),
    const _DurationOption('ثلاث ساعات', 180),
    const _DurationOption('أخرى', -1),
  ];

  int selectedIndex = 0;

  final result = await showDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 24.h,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              titlePadding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 6.h),
              contentPadding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 0),
              title: Text(
                'غير متاح لمدة',
                style: AppTextStyle.blackW700Size26.copyWith(fontSize: 22.sp),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(options.length, (i) {
                      final opt = options[i];
                      final selected = selectedIndex == i;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? AppStyle.primaryColor
                                : const Color(0xFFEDEDED),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          onTap: () => setState(() => selectedIndex = i),
                          title: Text(
                            opt.label,
                            textAlign: TextAlign.right,
                            style: AppTextStyle.blackW600Size12Roboto,
                          ),
                          trailing: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: selected
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            child: selected
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              actions: [
                DefaultButton(
                  backgroundColorButton: AppStyle.primaryColor,
                  buttonTitle: 'تم',
                  onPressed: () {
                    int minutes = options[selectedIndex].minutes;
                    Navigator.of(ctx).pop(minutes);
                  },
                  borderRadius: BorderRadius.circular(47.r),
                ),
              ],
            );
          },
        ),
      );
    },
  );

  return result;
}

class _DurationOption {
  final String label;
  final int minutes; // -1 means "Other"
  const _DurationOption(this.label, this.minutes);
}
