import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/filter/widgets/filter_tile.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class FilterHomeScreen extends StatefulWidget {
  const FilterHomeScreen({super.key});

  @override
  State<FilterHomeScreen> createState() => _FilterHomeScreenState();
}

class _FilterHomeScreenState extends State<FilterHomeScreen> {
  // Single-select index
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    // Build options from localization
    final List<String> options = <String>[
      l.filter_opt_9_12,
      l.filter_opt_12_3,
      l.filter_opt_3_6,
      l.filter_opt_6_9,
      l.filter_opt_9_12, // same as first (as in your screenshot)
    ];

    const Color primary = Color(0xFF00AEEF);
    const Color selectedBg = Color(0xFFE9F7FF);
    const Color borderGrey = Color(0xFFEDEDED);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            l.filter_title,
            style: TextStyle(
              color: const Color(0xFF232323),
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                itemCount: options.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final bool selected = _selectedIndex == index;
                  return FilterTile(
                    label: options[index],
                    selected: selected,
                    onTap: () => setState(() => _selectedIndex = index),
                    selectedBg: selectedBg,
                    primary: primary,
                    borderGrey: borderGrey,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              child: DefaultButton(
                onPressed: (){},
                backgroundColorButton: AppStyle.primaryColor,
                buttonTitle: l.filter_apply,
                borderRadius: BorderRadius.circular(30.r),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

