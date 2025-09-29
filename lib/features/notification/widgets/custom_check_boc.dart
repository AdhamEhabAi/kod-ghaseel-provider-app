import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: value ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: value
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : const SizedBox.shrink(),
      ),
    );
  }
}
