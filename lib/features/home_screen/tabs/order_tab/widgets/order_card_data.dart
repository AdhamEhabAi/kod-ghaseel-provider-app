import 'package:flutter/material.dart';

import '../../../../../Utilites/app_fonts/font.dart';

class OrderCardData extends StatelessWidget {
  const OrderCardData({super.key, required this.value, required this.field});

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(field, style: AppTextStyle.greyW600Size12Roboto),
        Spacer(),
        Text(
          textDirection: TextDirection.ltr,
          value,
          style: AppTextStyle.primaryW600Size12,
        ),
      ],
    );
  }
}
