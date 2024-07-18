import 'package:flutter/material.dart';

class BoxDecorationExtension extends ThemeExtension<BoxDecorationExtension> {
  final BoxDecoration? homeBackground;

  BoxDecorationExtension({required this.homeBackground});

  @override
  ThemeExtension<BoxDecorationExtension> copyWith({BoxDecoration? homeBackground}) {
    return BoxDecorationExtension(homeBackground: homeBackground ?? this.homeBackground);
  }

  @override
  ThemeExtension<BoxDecorationExtension> lerp(covariant ThemeExtension<dynamic>? other, double t) {
    if (other is! BoxDecorationExtension) return this;
    return BoxDecorationExtension(
      homeBackground: BoxDecoration.lerp(homeBackground, other.homeBackground, t),
    );
  }
}
