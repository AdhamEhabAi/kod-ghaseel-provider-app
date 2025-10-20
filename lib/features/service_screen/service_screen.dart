import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/adding_address_title_widget.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_container.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../generated/l10n.dart';
import '../../shared/shared_widget.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(24.7136, 46.6753);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 12,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                  ),
                  ServiceScreenAppBar(text: s.mapAddress), // ✅ localized
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
              child: UserDataSection(name: "سارة محمد",subtitle: s.client,),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverToBoxAdapter(
            child: AddingAddressTitleWidget(title: s.day_and_time),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
          SliverToBoxAdapter(
            child: ServiceScreenContainer(title: s.day_time_for_service,subtitle:"AM 05:00" ,),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
          SliverToBoxAdapter(
            child: AddingAddressTitleWidget(title: s.service_type),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
          SliverToBoxAdapter(
            child: ServiceScreenContainer(title: s.service_title,subtitle:s.car_data ,),
          ),
        ],
      ),

      floatingActionButton: DefaultButton(
        onPressed: () {
          // Todo: navigate to order progress screen
        },
        titleWidget: Text(
          s.startService, 
          style: AppTextStyle.blackW600Size16Roboto.copyWith(
            color: Colors.white,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.8,
        borderRadius: BorderRadius.circular(24.r),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

