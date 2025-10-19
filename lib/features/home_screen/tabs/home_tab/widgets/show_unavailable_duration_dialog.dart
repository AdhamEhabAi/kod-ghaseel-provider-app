import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

Future<int?> showUnavailableDurationDialog(BuildContext context) async {
  final l = S.of(context);

  final options = <_DurationOption>[
    _DurationOption(l.oneHour, 60),
    _DurationOption(l.twoHours, 120),
    _DurationOption(l.threeHours, 180),
    _DurationOption(l.other, -1),
  ];

  int selectedIndex = 0;
  final controller = TextEditingController();

  final result = await showDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (ctx, setState) {
            final isOther = options[selectedIndex].minutes == -1;

            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              titlePadding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 6.h),
              contentPadding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 0),
              title: Text(
                l.unavailableForLabel, // "غير متاح لمدة"
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
                        margin: EdgeInsets.only(bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: selected ? AppStyle.primaryColor : const Color(0xFFEDEDED),
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
                            width: 22.w, height: 22.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.8),
                              borderRadius: BorderRadius.circular(4.r),
                              color: selected ? Colors.black : Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            child: selected
                                ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                                : null,
                          ),
                        ),
                      );
                    }),

                    if (isOther)
                      Padding(
                        padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
                        child: CustomTextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          hintText: l.enterMinutesHint, // "اكتب عدد الدقائق"
                        ),
                      ),
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              actions: [
                DefaultButton(
                  backgroundColorButton: AppStyle.primaryColor,
                  buttonTitle: l.done, // "تم"
                  borderRadius: BorderRadius.circular(47.r),
                  onPressed: () {
                    int minutes = options[selectedIndex].minutes;
                    if (minutes == -1) {
                      final parsed = int.tryParse(controller.text.trim());
                      if (parsed == null || parsed <= 0) {
                        // simple guard: don’t close if invalid
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(content: Text(l.invalidMinutesMsg)), // "من فضلك أدخل عدد دقائق صالح"
                        );
                        return;
                      }
                      minutes = parsed;
                    }
                    Navigator.of(ctx).pop(minutes);
                  },
                ),
              ],
            );
          },
        ),
      );
    },
  );

  controller.dispose();
  return result;
}

class _DurationOption {
  final String label;
  final int minutes; // -1 => Other
  const _DurationOption(this.label, this.minutes);
}
