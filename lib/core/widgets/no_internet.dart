import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';


class NoInternetSheet extends StatelessWidget {
  const NoInternetSheet({super.key});


  // localizations.no_internet
  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
            color: AppStyle.red
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                Flexible(
                  child: Text(
                    localizations.no_internet,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Image.asset(
                  Assets.noInternet,
                  height: 28.h,
                  width: 28.w,
                  color: AppStyle.white,
                ),
              ],
            ),
          ),
        ),

        // Consumer<LoadingProvider>(
        //   builder: (context, loadingProvider, child) {
        //     return Container(
        //       padding: EdgeInsets.only(top: 150.h),
        //       child: loadingProvider.isLoading
        //           ? const Center(
        //               child: AppLoader(color: AppColors.red,)
        //             )
        //           : CustomButton(
        //               text: localizations.customButton,
        //               onPressed: () => _handleGotItPressed(context),
        //               color: AppColors.red,
        //               height: 35.h,
        //             ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
