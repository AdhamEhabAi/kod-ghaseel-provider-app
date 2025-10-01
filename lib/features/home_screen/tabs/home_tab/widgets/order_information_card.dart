import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
    required this.clientName,
    required this.serviceDescription,
  });

  final String clientName;
  final String serviceDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [Color(0xFF01D0FE), Color(0xFF00728C)],
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(clientName, style: AppTextStyle.whiteW600Size14Roboto),
            Text(serviceDescription,style: AppTextStyle.blackW400Size12Roboto.copyWith(color: Color(0xffB9F2FF)),)
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w,vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Text("قبول",style: AppTextStyle.primaryW600Size12,),
        )
      ]),
    );
  }
}
