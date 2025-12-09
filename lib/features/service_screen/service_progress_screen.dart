import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/setting_app_bar.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/data/models/order_stages_model.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_steps_rows.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/upper_card_progress.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class ServiceProgressScreen extends StatefulWidget {
  final int? orderId;

  const ServiceProgressScreen({super.key, this.orderId});

  @override
  State<ServiceProgressScreen> createState() => _ServiceProgressScreenState();
}

class _ServiceProgressScreenState extends State<ServiceProgressScreen> {
  // Step management: 0 = arrival, 1 = check car, 2 = start washing, 3 = drying, 4 = finish
  int _currentStep = 0;
  DateTime? _arrivalTime;

  // Washing timer
  DateTime? _washingTimerStartTime;
  Timer? _washingTimer;
  Duration _washingElapsedTime = Duration.zero;
  bool _isWashingTimerRunning = false;
  Duration? _finalWashingDuration; // Store final duration when washing ends

  // Drying timer
  DateTime? _dryingTimerStartTime;
  Timer? _dryingTimer;
  Duration _dryingElapsedTime = Duration.zero;
  bool _isDryingTimerRunning = false;
  Duration? _finalDryingDuration; // Store final duration when drying ends
  
  // Order stages data
  OrderStagesData? _orderStagesData;
  bool _hasCalledAcceptOrder = false;

  @override
  void initState() {
    super.initState();
    
    // If orderId is null, navigate back to home screen
    if (widget.orderId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Clear any stored service progress state
          AppSharedPreferences.remove(SharedPreferencesKeys.serviceProgressOrderId);
          GoRouter.of(context).pushReplacement(AppRouter.homeScreen);
        }
      });
      return;
    }
    
    // Set arrival time when screen loads
    _arrivalTime = DateTime.now();

    // Store orderId in shared preferences to restore on app restart
    AppSharedPreferences.setInt(
      SharedPreferencesKeys.serviceProgressOrderId,
      widget.orderId!,
    );

    // Fetch order stages on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceCubit>().getOrderStages(widget.orderId!);
    });
  }

  @override
  void dispose() {
    _washingTimer?.cancel();
    _dryingTimer?.cancel();
    super.dispose();
  }

  void _startWashingTimer() {
    if (!_isWashingTimerRunning) {
      _washingTimerStartTime = DateTime.now();
      _isWashingTimerRunning = true;
      _washingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _washingElapsedTime = DateTime.now().difference(
              _washingTimerStartTime!,
            );
          });
        }
      });
    }
  }

  void _stopWashingTimer() {
    _washingTimer?.cancel();
    _isWashingTimerRunning = false;
    // Calculate and store final washing duration
    if (_washingTimerStartTime != null) {
      _finalWashingDuration = DateTime.now().difference(_washingTimerStartTime!);
      _washingElapsedTime = _finalWashingDuration!;
    }
  }

  void _startDryingTimer() {
    if (!_isDryingTimerRunning) {
      _dryingTimerStartTime = DateTime.now();
      _isDryingTimerRunning = true;
      _dryingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _dryingElapsedTime = DateTime.now().difference(
              _dryingTimerStartTime!,
            );
          });
        }
      });
    }
  }

  void _stopDryingTimer() {
    _dryingTimer?.cancel();
    _isDryingTimerRunning = false;
    // Calculate and store final drying duration
    if (_dryingTimerStartTime != null) {
      _finalDryingDuration = DateTime.now().difference(_dryingTimerStartTime!);
      _dryingElapsedTime = _finalDryingDuration!;
    }
  }

  /// Calculate washing duration from stages data (for restoring after hot restart)
  void _calculateWashingDurationFromStages(OrderStagesData stagesData) {
    if (_finalWashingDuration != null) return; // Already calculated
    
    try {
      final washingStarted = stagesData.stages.firstWhere(
        (stage) => stage.stage == 'washing_started',
        orElse: () => OrderStage(id: 0, stage: '', stageTime: ''),
      );
      final washingCompleted = stagesData.stages.firstWhere(
        (stage) => stage.stage == 'washing_completed',
        orElse: () => OrderStage(id: 0, stage: '', stageTime: ''),
      );
      
      if (washingStarted.stageTime.isNotEmpty && 
          washingCompleted.stageTime.isNotEmpty) {
        final startTime = DateTime.parse(washingStarted.stageTime);
        final endTime = DateTime.parse(washingCompleted.stageTime);
        _finalWashingDuration = endTime.difference(startTime);
        _washingElapsedTime = _finalWashingDuration!;
      }
    } catch (e) {
      debugPrint('⚠️ [ServiceProgressScreen] Error calculating washing duration: $e');
    }
  }

  /// Calculate drying duration from stages data (for restoring after hot restart)
  void _calculateDryingDurationFromStages(OrderStagesData stagesData) {
    if (_finalDryingDuration != null) return; // Already calculated
    
    try {
      final dryingStarted = stagesData.stages.firstWhere(
        (stage) => stage.stage == 'drying_started',
        orElse: () => OrderStage(id: 0, stage: '', stageTime: ''),
      );
      final dryingCompleted = stagesData.stages.firstWhere(
        (stage) => stage.stage == 'drying_completed',
        orElse: () => OrderStage(id: 0, stage: '', stageTime: ''),
      );
      
      if (dryingStarted.stageTime.isNotEmpty && 
          dryingCompleted.stageTime.isNotEmpty) {
        final startTime = DateTime.parse(dryingStarted.stageTime);
        final endTime = DateTime.parse(dryingCompleted.stageTime);
        _finalDryingDuration = endTime.difference(startTime);
        _dryingElapsedTime = _finalDryingDuration!;
      }
    } catch (e) {
      debugPrint('⚠️ [ServiceProgressScreen] Error calculating drying duration: $e');
    }
  }

  void _handleButtonPress(S s) {
    if (widget.orderId == null) return;

    // Don't increment step here - wait for API success
    if (_currentStep < 2) {
      // First two steps: "Check" button - call API
      if (_currentStep == 0) {
        // Step 0: Arrival - call arrived API
        context.read<ServiceCubit>().markArrived(
          widget.orderId!,
          notes: s.arrivalNotes,
        );
      } else if (_currentStep == 1) {
        // Step 1: Check car - call car_verified API
        context.read<ServiceCubit>().verifyCar(widget.orderId!);
      }
    } else if (_currentStep == 2) {
      // Third step (start washing): "Start" button - start timer but stay on this step
      if (!_isWashingTimerRunning) {
        _startWashingTimer();
        // Call washing_started API
        context.read<ServiceCubit>().startWashing(widget.orderId!);
      } else {
        // If washing timer is running, "Next" button stops washing timer
        _stopWashingTimer();
        // Call washing_completed API - will move to next step on success
        context.read<ServiceCubit>().completeWashing(widget.orderId!);
      }
    } else if (_currentStep == 3) {
      // Fourth step (drying): "Next" button - stop drying timer
      _stopDryingTimer();
      // Call drying_completed API - will move to next step on success
      context.read<ServiceCubit>().completeDrying(widget.orderId!);
    } else if (_currentStep == 4) {
      // Fifth step (finish): "Finish" button - complete order
      context.read<ServiceCubit>().completeOrder(widget.orderId!);
    }
  }

  String _getFriendlyErrorMessage(S s, String action, String? originalMessage) {
    // Map actions to friendly localized messages
    final messages = {
      'accept_order': s.errorAcceptOrder,
      'arrived': s.errorArrived,
      'car_verified': s.errorCarVerified,
      'washing_started': s.errorWashingStarted,
      'washing_completed': s.errorWashingCompleted,
      'drying_started': s.errorDryingStarted,
      'drying_completed': s.errorDryingCompleted,
      'complete_order': s.errorCompleteOrder,
      'get_order_stages': s.errorLoadOrderStages,
    };

    // Return friendly message or original if not found
    return messages[action] ?? originalMessage ?? s.genericError;
  }

  String _getButtonText(S s) {
    if (_currentStep < 2) {
      return s.check;
    } else if (_currentStep == 2) {
      // On step 2, show "Start" if washing timer not running, "Next" if timer is running
      return _isWashingTimerRunning ? s.next : s.start;
    } else if (_currentStep == 3) {
      return s.next;
    } else {
      return s.finishService;
    }
  }

  Color _getButtonColor() {
    if (_currentStep < 2) {
      return const Color(0xFFE3F2FD); // Light blue for check
    } else if (_currentStep == 2) {
      // Green for "Start", blue for "Next" after washing timer started
      return _isWashingTimerRunning
          ? const Color(0xFFE3F2FD)
          : const Color(0xFFE8F5E9); // Light green for start, blue for next
    } else if (_currentStep == 3) {
      return const Color(0xFFE3F2FD); // Light blue for next
    } else {
      return const Color(0xFFE9F9EE); // Light green for finish
    }
  }

  Color _getButtonTextColor() {
    if (_currentStep < 2) {
      return const Color(0xFF1976D2); // Blue
    } else if (_currentStep == 2) {
      // Green for "Start", blue for "Next" after washing timer started
      return _isWashingTimerRunning
          ? const Color(0xFF1976D2)
          : const Color(0xFF17BF63); // Green for start, blue for next
    } else if (_currentStep == 3) {
      return const Color(0xFF1976D2); // Blue
    } else {
      return const Color(0xFF17BF63); // Green
    }
  }

  double _calculateProgress() {
    // Progress based on steps: 0% -> 20% -> 40% -> 60% -> 80% -> 100%
    return (_currentStep / 4) * 100;
  }

  Duration _getCurrentTimerDuration() {
    // Return the active timer duration based on current step
    if (_isWashingTimerRunning) {
      return _washingElapsedTime;
    } else if (_isDryingTimerRunning) {
      return _dryingElapsedTime;
    }
    return Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return PopScope(
      canPop: false, // Prevent going back from service progress screen
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Don't allow back navigation - user must complete the service
      },
      child: BlocListener<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is OrderStagesLoaded) {
          // Store the stages data
          _orderStagesData = state.stagesData;
          
          // Check if stages are empty - if so, call acceptOrder (only once)
          if (state.stagesData.stages.isEmpty && !_hasCalledAcceptOrder) {
            debugPrint('📋 [ServiceProgressScreen] No stages found, calling acceptOrder');
            _hasCalledAcceptOrder = true;
            if (widget.orderId != null) {
              context.read<ServiceCubit>().acceptOrder(widget.orderId!);
            }
          } else if (state.stagesData.stages.isNotEmpty) {
            // Handle loaded stages - update current step based on server data
            final currentStage = state.stagesData.currentStage;
            if (currentStage != null) {
              setState(() {
                // Map server stages to local steps
                // Note: current_stage means the LAST completed stage
                // accepted -> step 0 (arrival - not yet arrived)
                // arrived -> step 1 (check car - already arrived)
                // car_verified -> step 2 (start washing - car already verified)
                // washing_started -> step 2 (start washing - timer should be running)
                // washing_completed or drying_started -> step 3 (drying)
                // drying_completed -> step 4 (finish)
                if (currentStage == 'accepted') {
                  // Order accepted but not yet arrived
                  _currentStep = 0;
                } else if (currentStage == 'arrived') {
                  // Already arrived - move to step 1 (check car)
                  _currentStep = 1;
                } else if (currentStage == 'car_verified') {
                  // Car already verified - move to step 2 (start washing)
                  _currentStep = 2;
                } else if (currentStage == 'washing_started') {
                  // Washing started - stay on step 2, start timer
                  _currentStep = 2;
                  _startWashingTimer();
                } else if (currentStage == 'washing_completed') {
                  // Washing completed - move to step 3, start drying timer
                  _currentStep = 3;
                  // Calculate final washing duration from stages if available
                  _calculateWashingDurationFromStages(state.stagesData);
                  _startDryingTimer();
                } else if (currentStage == 'drying_started') {
                  // Drying started - stay on step 3, timer should be running
                  _currentStep = 3;
                  // Calculate final washing duration from stages if available
                  _calculateWashingDurationFromStages(state.stagesData);
                  _startDryingTimer();
                } else if (currentStage == 'drying_completed') {
                  // Drying completed - move to step 4 (finish)
                  _currentStep = 4;
                  // Calculate final durations from stages if available
                  _calculateWashingDurationFromStages(state.stagesData);
                  _calculateDryingDurationFromStages(state.stagesData);
                }
              });
            }
          }
        } else if (state is OrderStagesError) {
          // Show friendly error message for get_order_stages
          ToastM.show(
            _getFriendlyErrorMessage(s, 'get_order_stages', state.message),
          );
        } else if (state is OrderStageActionSuccess) {
          // If acceptOrder succeeded, refresh stages to get updated data
          if (_hasCalledAcceptOrder && 
              (_orderStagesData == null || _orderStagesData!.stages.isEmpty)) {
            debugPrint('📋 [ServiceProgressScreen] acceptOrder succeeded, refreshing stages');
            if (widget.orderId != null) {
              context.read<ServiceCubit>().getOrderStages(widget.orderId!);
            }
            return; // Don't process step changes yet, wait for stages to reload
          }
          
          // Check which action succeeded to determine what to do
          final action = state.action;
          
          // Move to next step only on success, based on the action
          setState(() {
            if (action == 'arrived') {
              // Arrival success - move to step 1
              _currentStep = 1;
            } else if (action == 'car_verified') {
              // Car verified success - move to step 2
              _currentStep = 2;
            } else if (action == 'washing_started') {
              // Washing started success - stay on step 2, timer is already running
              // Don't change step, just stay here
            } else if (action == 'washing_completed') {
              // Washing completed success - stop washing timer, move to step 3 and start drying timer
              _stopWashingTimer(); // This will calculate and store final washing duration
              _currentStep = 3;
              _startDryingTimer();
              // Call drying_started API - will handle success in next state
              if (widget.orderId != null) {
                context.read<ServiceCubit>().startDrying(widget.orderId!);
              }
            } else if (action == 'drying_started') {
              // Drying started success - stay on step 3, timer is already running
              // Don't change step, just stay here
            } else if (action == 'drying_completed') {
              // Drying completed success - stop drying timer and move to step 4
              _stopDryingTimer(); // This will calculate and store final drying duration
              _currentStep = 4;
            } else if (action == 'complete_order') {
              // Order completed - show success message
              ToastM.show(s.orderCompletedSuccess);
              // Clear stored service progress state
              AppSharedPreferences.remove(SharedPreferencesKeys.serviceProgressOrderId);
              // Navigate to home screen with replacement
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  GoRouter.of(context).pushReplacement(AppRouter.homeScreen);
                }
              });
            }
          });
        } else if (state is OrderStageActionError) {
          // Show friendly error message using the action from the error state
          ToastM.show(_getFriendlyErrorMessage(s, state.action, state.message));
          
          // If drying_started fails, make sure washing timer is still running (if we're on step 2)
          // If washing_completed fails, make sure we don't have both timers running
          if (state.action == 'drying_started' && _currentStep == 2) {
            // This shouldn't happen, but if it does, stop the drying timer if it's running
            if (_isDryingTimerRunning) {
              _stopDryingTimer();
            }
          } else if (state.action == 'washing_completed' && _currentStep == 2) {
            // If washing_completed fails, we should still be on step 2 with washing timer running
            // Make sure drying timer is not running
            if (_isDryingTimerRunning) {
              _stopDryingTimer();
            }
          }
          
          // Don't change step - stay on current step
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6F7),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 8.h),
                  SettingAppBar(title: s.orderProgressTitle,hideBack: true,), // "تقدم الطلب"
                  SizedBox(height: 24.h),
                  UpperCardProgress(
                    elapsedTime: _getCurrentTimerDuration(),
                    progress: _calculateProgress(),
                    isTimerRunning:
                        _isWashingTimerRunning || _isDryingTimerRunning,
                  ),
                  SizedBox(height: 24.h),
                  ServiceStepsRows(
                    currentStep: _currentStep,
                    arrivalTime: _arrivalTime,
                    washingElapsedTime: _washingElapsedTime,
                    dryingElapsedTime: _dryingElapsedTime,
                    isWashingTimerRunning: _isWashingTimerRunning,
                    isDryingTimerRunning: _isDryingTimerRunning,
                    finalWashingDuration: _finalWashingDuration,
                    finalDryingDuration: _finalDryingDuration,
                  ),
                  SizedBox(height: 24.h),
                  DefaultButton(
                    borderRadius: BorderRadius.circular(60.r),
                    backgroundColorButton: _getButtonColor(),
                    titleWidget: Text(
                      _getButtonText(s),
                      style: TextStyle(
                        color: _getButtonTextColor(),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: (){
                      _handleButtonPress(s);
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
