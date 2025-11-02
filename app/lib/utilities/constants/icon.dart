import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String apple = 'lib/assets/icons/apple.svg';
final String facebook = 'lib/assets/icons/facebook.svg';
final String google = 'lib/assets/icons/google.svg';
final String x = 'lib/assets/icons/x.svg';

class AppIcons {
  static Widget facebookSvg = SvgPicture.asset(
    facebook,
    semanticsLabel: 'facebook logo',
  );

  static Widget googleSvg = SvgPicture.asset(
    google,
    semanticsLabel: 'google logo',
  );

  static Widget xSvg = SvgPicture.asset(x, semanticsLabel: 'x logo');

  static Widget appleSvg = SvgPicture.asset(
    apple,
    semanticsLabel: 'apple logo',
  );
}
