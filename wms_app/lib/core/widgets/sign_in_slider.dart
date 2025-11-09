import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/size.dart';

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
          image: AssetImage('lib/core/assets/images/Mask_Layer.png'),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0)),
      ),
    );
  }
}
