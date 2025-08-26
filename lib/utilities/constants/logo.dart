import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final String logoLarge = 'lib/assets/logo/logo_l.svg';

class AppLogo extends StatelessWidget {
  final double? svgWidth;
  final double? svgHeight;

  const AppLogo({super.key, this.svgWidth, this.svgHeight});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      logoLarge,
      width: svgWidth,
      height: svgHeight,
      semanticsLabel: 'app logo',
    );
  }
}
