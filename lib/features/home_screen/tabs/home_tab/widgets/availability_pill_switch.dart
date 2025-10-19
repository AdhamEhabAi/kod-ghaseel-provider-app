import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <- adjust if your S path differs

class AvailabilityPillSwitch extends StatefulWidget {
  const AvailabilityPillSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.onBeforeToggle,
    this.width,
    this.height,
    this.backgroundColor,
    this.textGap,
  });

  /// Current value (controlled)
  final bool value;

  /// Called only if the toggle proceeds
  final ValueChanged<bool>? onChanged;

  /// Called before toggling. Return false to **veto** the toggle.
  /// Useful to open a sheet/confirm dialog.
  final Future<bool> Function(bool nextValue)? onBeforeToggle;

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? textGap;

  @override
  State<AvailabilityPillSwitch> createState() => _AvailabilityPillSwitchState();
}

class _AvailabilityPillSwitchState extends State<AvailabilityPillSwitch> {
  bool _animating = false; // avoid spam taps during animation

  Future<void> _tryToggle() async {
    if (_animating) return;
    final next = !widget.value;
    bool proceed = true;
    if (widget.onBeforeToggle != null) {
      proceed = await widget.onBeforeToggle!(next);
    }
    if (proceed) {
      setState(() => _animating = true);
      widget.onChanged?.call(next);
      await Future.delayed(const Duration(milliseconds: 230));
      if (mounted) setState(() => _animating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context); // localization
    final isOn = widget.value;

    final w = (widget.width ?? 90.w).clamp(96.0, 220.0);
    final h = (widget.height ?? 34.h).clamp(28.0, 56.0);

    final double dotSize = (h * 0.52).clamp(12.0, 22.0);
    const double innerMargin = 4.0;
    const double textSidePadding = 6.0;
    final double safePad =
        (dotSize / 2) + innerMargin + (widget.textGap ?? 2.0);

    const duration = Duration(milliseconds: 220);
    const curve = Curves.easeOut;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _tryToggle,
        borderRadius: BorderRadius.circular(h / 2),
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Track
              Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color:
                      (widget.backgroundColor ??
                      const Color(0xFF1FA4B5).withOpacity(0.85)),
                  borderRadius: BorderRadius.circular(h / 2),
                ),
              ),

              // Text layer
              Positioned.fill(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Stack(
                    children: [
                      // ON -> dot right, text left
                      AnimatedOpacity(
                        opacity: isOn ? 1 : 0,
                        duration: duration,
                        curve: curve,
                        child: AnimatedPadding(
                          duration: duration,
                          curve: curve,
                          padding: EdgeInsets.only(
                            right: isOn ? safePad : 0,
                            left: textSidePadding,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              l.status_availableNow, // "متاح الآن"
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: (h * 0.44),
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // OFF -> dot left, text right
                      AnimatedOpacity(
                        opacity: isOn ? 0 : 1,
                        duration: duration,
                        curve: curve,
                        child: AnimatedPadding(
                          duration: duration,
                          curve: curve,
                          padding: EdgeInsets.only(
                            left: !isOn ? safePad : 0,
                            right: textSidePadding,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              l.status_unavailable, // "غير متاح"
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: (h * 0.44),
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Dot
              Positioned.fill(
                child: AnimatedAlign(
                  duration: duration,
                  curve: curve,
                  alignment: isOn
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: dotSize,
                    height: dotSize,
                    margin: const EdgeInsets.all(innerMargin),
                    decoration: BoxDecoration(
                      color: isOn ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
