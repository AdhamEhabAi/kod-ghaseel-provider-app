import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_fonts/font.dart';
import '../../../generated/l10n.dart'; // ✅ localization import

class AddingAddressTitleWidget extends StatelessWidget {
  const AddingAddressTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Localized title text
          Text(
            title,
            style: AppTextStyle.blackW600Size16Roboto,
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
