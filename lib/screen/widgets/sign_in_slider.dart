import 'package:e_wms_mobile/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class SignInSlider extends StatefulWidget {
  const SignInSlider({super.key});

  @override
  State<SignInSlider> createState() => _SignInSliderState();
}

class _SignInSliderState extends State<SignInSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: AppSizeStyle.fullWidth(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/Mask_Layer.png'),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0)),
      ),
    );
  }
}
