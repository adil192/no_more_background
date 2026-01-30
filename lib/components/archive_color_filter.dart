import 'package:flutter/material.dart';

class ArchiveColorFilter extends StatelessWidget {
  const ArchiveColorFilter({
    super.key,
    required this.archived,
    required this.child,
  });

  final bool archived;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!archived) return child;
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(_colorFilter),
      child: child,
    );
  }

  static final _colorFilter = _saturate(0.3);

  static List<double> _saturate(double s) {
    const r = 0.2126, g = 0.7152, b = 0.0722;
    return [
      r + (1 - r) * s, g * (1 - s), b * (1 - s), 0, 0, //
      r * (1 - s), g + (1 - g) * s, b * (1 - s), 0, 0, //
      r * (1 - s), g * (1 - s), b + (1 - b) * s, 0, 0, //
      0, 0, 0, 1, 0, //
    ];
  }
}
