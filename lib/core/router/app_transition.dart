import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Common transition types to keep usage readable.
enum AppTransition {
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  fade,
  scale,
  none,
}

class TransitionHelper {
  TransitionHelper._();

  /// Entry point used from GoRoute.pageBuilder
  static CustomTransitionPage<T> page<T>({
    required Widget child,
    required GoRouterState state,
    AppTransition transition = AppTransition.slideFromRight,
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.easeOutCubic,
    Color? barrierColor,
    String? barrierLabel,
    bool fullscreenDialog = false,
    bool maintainState = true,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      barrierColor: barrierColor,
      barrierDismissible: false,
      barrierLabel: barrierLabel,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case AppTransition.slideFromRight:
            return _slide(child, animation, const Offset(1, 0), curve);
          case AppTransition.slideFromLeft:
            return _slide(child, animation, const Offset(-1, 0), curve);
          case AppTransition.slideFromBottom:
            return _slide(child, animation, const Offset(0, 1), curve);
          case AppTransition.fade:
            return _fade(child, animation, curve);
          case AppTransition.scale:
            return _scale(child, animation, curve);
          case AppTransition.none:
            return child;
        }
      },
    );
  }

  // ---- Builders ----

  static Widget _slide(
      Widget child,
      Animation<double> animation,
      Offset begin,
      Curve curve,
      ) {
    final tween = Tween<Offset>(begin: begin, end: Offset.zero)
        .chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  static Widget _fade(
      Widget child,
      Animation<double> animation,
      Curve curve,
      ) {
    final tween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: curve));
    return FadeTransition(opacity: animation.drive(tween), child: child);
  }

  static Widget _scale(
      Widget child,
      Animation<double> animation,
      Curve curve,
      ) {
    final tween =
    Tween<double>(begin: 0.96, end: 1).chain(CurveTween(curve: curve));
    return FadeTransition(
      opacity: animation.drive(Tween<double>(begin: 0, end: 1)
          .chain(CurveTween(curve: curve))),
      child: ScaleTransition(scale: animation.drive(tween), child: child),
    );
  }
}
