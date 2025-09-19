import 'package:flutter/widgets.dart';

/// Global layout constants to align screens with wireframes
class AppLayout {
  // Max content widths per screen type
  static const double pageMaxWidthNarrow = 420;
  static const double pageMaxWidthWide = 520;

  // Standard paddings
  static const EdgeInsets pagePadding = EdgeInsets.all(24);
  static const EdgeInsets pagePaddingTight = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  // Controls
  static const double controlHeight = 48; // buttons/textfields
  static const double listTileLeadingRadius = 22;
}
