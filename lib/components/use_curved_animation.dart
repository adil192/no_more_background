import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

CurvedAnimation useCurvedAnimation({
  required Animation<double> parent,
  required Curve curve,
  Curve? reverseCurve,
}) {
  return use(
    _CurvedAnimationHook(
      parent: parent,
      curve: curve,
      reverseCurve: reverseCurve,
    ),
  );
}

class _CurvedAnimationHook extends Hook<CurvedAnimation> {
  const _CurvedAnimationHook({
    required this.parent,
    required this.curve,
    this.reverseCurve,
  });

  final Animation<double> parent;
  final Curve curve;
  final Curve? reverseCurve;

  @override
  _CurvedAnimationHookState createState() => _CurvedAnimationHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('parent', parent));
    properties.add(DiagnosticsProperty('curve', curve));
    properties.add(DiagnosticsProperty('reverseCurve', reverseCurve));
  }
}

class _CurvedAnimationHookState
    extends HookState<CurvedAnimation, _CurvedAnimationHook> {
  late var _curvedAnimation = _createCurvedAnimation();
  CurvedAnimation _createCurvedAnimation() => CurvedAnimation(
    parent: hook.parent,
    curve: hook.curve,
    reverseCurve: hook.reverseCurve,
  );

  @override
  void didUpdateHook(_CurvedAnimationHook oldHook) {
    super.didUpdateHook(oldHook);

    if (hook.parent != oldHook.parent) {
      _curvedAnimation.dispose();
      _curvedAnimation = _createCurvedAnimation();
    } else if (hook.curve != oldHook.curve ||
        hook.reverseCurve != oldHook.reverseCurve) {
      _curvedAnimation.curve = hook.curve;
      _curvedAnimation.reverseCurve = hook.reverseCurve;
    }
  }

  @override
  CurvedAnimation build(BuildContext context) => _curvedAnimation;

  @override
  void dispose() {
    _curvedAnimation.dispose();
  }

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useCurvedAnimation';
}
