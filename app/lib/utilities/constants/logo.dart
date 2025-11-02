import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final String logoLarge = 'lib/assets/logo/logo_l.svg';
final String whiteLogo = 'lib/assets/logo/white.svg';

class AppLogo extends StatelessWidget {
  final String element;
  final double? svgWidth;
  final double? svgHeight;

  const AppLogo({
    super.key,
    this.svgWidth,
    this.svgHeight,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      element,
      width: svgWidth,
      height: svgHeight,
      semanticsLabel: 'app logo',
    );
  }
}
