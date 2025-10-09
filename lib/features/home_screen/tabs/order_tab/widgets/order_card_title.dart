import 'package:flutter/material.dart';

import '../../../../../Utilites/app_fonts/font.dart';

class OrderCardTitle extends StatelessWidget {
  const OrderCardTitle({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyle.blackW600Size16Roboto),
        Spacer(),
        Text(
          value,
          style: AppTextStyle.blackW600Size16Roboto.copyWith(fontFamily: "Poppins")
        ),
      ],
    );
  }
}
