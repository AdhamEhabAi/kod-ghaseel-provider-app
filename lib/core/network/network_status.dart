import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ConnectivityService extends ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;
  bool _hasSlowConnection = true;
  bool get hasSlowConnection => hasSlowConnection;
  // late StreamSubscription<ConnectivityResult> _subscription;
  final connectionChecker = InternetConnectionChecker.instance;

  ConnectivityService() {
    // checkInitialConnectivity();
    monitorConnection();
  }

  bool _initialStatusHandled = false;
  bool isOnline = true;
  Timer? _debounce;
  void monitorConnection() async {
    await Future.delayed(const Duration(seconds: 2));
    log('Checking internet connection...');
    connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) async {
        if (!_initialStatusHandled) {
          _initialStatusHandled = true;
          await Future.delayed(const Duration(milliseconds: 500));
          status = await connectionChecker.connectionStatus;
        }
        if (status == InternetConnectionStatus.connected) {
          log('Connected to the internet');
          setConnected(true);
          notifyListeners();
        } else {
          log('Disconnected from the internet, trying to ping google.com');
          final hasInternet = await hasInternetCheck();
          if (hasInternet) {
            log('Connected to the internet');
            setConnected(true);
            notifyListeners();
          } else {
            log('Ping to google.com failed');
            _debounce?.cancel();
            _debounce = Timer(const Duration(seconds: 2), () {
              setConnected(false);
              notifyListeners();
            });
          }
        }
      },
    );
  }

  Future<bool> hasInternetCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Future<void> checkInitialConnectivity() async {
  //   var result = await Connectivity().checkConnectivity();
  //   _updateConnectionStatus(result[0]);
  // }

  // void _updateConnectionStatus(ConnectivityResult result) {
  //   bool newConnectionState = result != ConnectivityResult.none;
  //   if (_isConnected != newConnectionState) {
  //     _isConnected = newConnectionState;
  //     notifyListeners();
  //   }
  // }

  // void monitorConnection() {
  //   Connectivity()..onConnectivityChanged.listen((result) {
  //     if (result == ConnectivityResult.none) {
  //       _isConnected = false;
  //
  //       debugPrint('emitting connection offline');
  //     } else {
  //       _isConnected = true;
  //
  //       debugPrint('emitting connection online, connection result = $result');
  //     }
  //     notifyListeners();
  //
  //   });
  // }
  void setConnected(bool connection) {
    if (_isConnected != connection) {
      _isConnected = connection;
      notifyListeners();
    }
  }

  void setSlowConnection(bool connection) {
    if (_hasSlowConnection != connection) {
      _hasSlowConnection = connection;
      notifyListeners();
    }
  }

  bool serviceEnabled = true;
  Timer? statusCheckTimer;
  bool mapShow = false;
  final Location _location = Location();
  void startPeriodicStatusCheck() async {
    // Get the current status of location services
    if (Platform.isAndroid) {
      serviceEnabled = await _location.serviceEnabled();

      // Emit the initial state explicitly
      if (!serviceEnabled) {
        debugPrint('Emitting initial location offline');
        notifyListeners();
      } else {
        debugPrint('Emitting initial location online');
        notifyListeners();
      }

      // Start periodic status checking
      statusCheckTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) async {
        bool isServiceEnabled = await _location.serviceEnabled();

        // Emit state only if there's a change in service status
        if (isServiceEnabled != serviceEnabled) {
          serviceEnabled = isServiceEnabled;

          if (!serviceEnabled) {
            debugPrint('Emitting location offline');
            notifyListeners();
          } else {
            debugPrint('Emitting location online');
            notifyListeners();
          }
        }
      });
    }
  }

  Future<void> requestLocationEnable() async {
    debugPrint('test location enabled');
    serviceEnabled = await _location.requestService();

    if (!serviceEnabled) {
      debugPrint('Emitting location offline');
      notifyListeners();
    } else {
      debugPrint('Emitting location online');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // _subscription.cancel();
    super.dispose();
  }
}
