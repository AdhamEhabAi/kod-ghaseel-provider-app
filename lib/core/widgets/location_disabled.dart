import 'package:flutter/material.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../core/network/network_status.dart';


class LocationDisabled extends StatelessWidget {
  const LocationDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    return Material( // ✅ أضف هذه
      color: Colors.transparent, // اجعل الخلفية شفافة أو حسب اللون الذي تريده
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(48),
                bottomLeft: Radius.circular(48),
              ),
              color: Colors.brown
              ,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: VectorGraphic(
                      loader: AssetBytesLoader( Assets.locationTick), // same .svg path as before
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                     localizations.location_disabled,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing:  Icon(
                      Icons.arrow_forward_ios,
                      color: AppStyle.white,
                    ),
                    onTap: () {
                      Provider.of<ConnectivityService>(
                        context,
                        listen: false,
                      ).requestLocationEnable();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
