import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../../Utilites/app_style/style.dart';



class NotificationSettingWidget extends StatelessWidget {
  NotificationSettingWidget({
    super.key,
    required this.title,
    required this.isOn,
    required this.onChange
  });
  final String title;
  late bool isOn;
  final Function(bool)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 42.w),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.blackW500Size16,
          ),
          Spacer(),
          CupertinoSwitch(
            activeColor: AppStyle.primaryColor,
            value: isOn,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
