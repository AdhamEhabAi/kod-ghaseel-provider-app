import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_back_button.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/custom_check_boc.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../generated/l10n.dart';
import 'controller/notification_cubit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool byDate = false;
  bool unreadOnly = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ Localization instance

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 121.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomBackButton(),
              SizedBox(height: 42.h),

              Row(
                children: [
                  Text(
                    s.filter,
                    style: AppTextStyle.blackW600Size28Roboto,
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16.r),
              //     border: Border.all(color: const Color(0xFFEDEDED)),
              //   ),
              //   child: Row(
              //     children: [
              //       CustomCheckBox(
              //         value: byDate,
              //         onChanged: (v) => setState(() => byDate = v),
              //       ),
              //       SizedBox(width: 16.w),
              //       GestureDetector(
              //         onTap: () {},
              //         child: Text(
              //           textDirection: TextDirection.rtl,
              //           s.filterByDate, // ✅ Localized
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              // SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFEDEDED)),
                ),
                child: Row(
                  children: [
                    CustomCheckBox(
                      value: unreadOnly,
                      onChanged: (v) => setState(() => unreadOnly = v),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        textDirection: TextDirection.rtl,
                        s.unread, // ✅ Localized
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ✅ Apply Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                    context.read<NotificationCubit>().filterByRead();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff01D0FE),
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 80.w,
                      vertical: 15.h,
                    ),
                    child: Text(
                      s.apply_filter, // ✅ Localized
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
