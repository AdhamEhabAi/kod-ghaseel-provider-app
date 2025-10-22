import 'package:flutter/material.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/location_disabled.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'network_status.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ConnectivityService>(context);
    final isConnected = service.isConnected;
    final isLocationEnabled = service.serviceEnabled;

    if (!isConnected) {
      return const NoInternetSheet();
    } else if (!isLocationEnabled) {
      return const LocationDisabled();
    } else {
      return const SizedBox(); // Nothing to show if both are fine
    }
  }
}

