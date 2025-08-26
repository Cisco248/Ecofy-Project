import 'package:e_wms_mobile/provider/signing_provider.dart';
import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:e_wms_mobile/utilities/constants/font.dart';
import 'package:e_wms_mobile/utilities/constants/icon.dart';
import 'package:e_wms_mobile/utilities/constants/text.dart';
import 'package:e_wms_mobile/screen/widgets/initial_appbar.dart';
import 'package:e_wms_mobile/screen/widgets/sign_in_slider.dart';
import 'package:e_wms_mobile/utilities/services/notification_service.dart';
import 'package:e_wms_mobile/utilities/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final email = _emailController.text;
  late final password = _passwordController.text;

  var valid = Validator();

  late final provider = Provider.of<SignInProvider>(context, listen: false);

  void submitData() {
    if (_formKey.currentState!.validate()) {
      var logCheck = provider.login(email, password);
      if (logCheck == true) {
        NotificationService(
          message: signInTextSuccess,
          context: context,
        ).signInNotification();
        Navigator.pushNamed(context, '/home');
      } else {
        NotificationService(
          message: signInTextFailed,
          context: context,
        ).signInNotification();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: InitialAppbar()),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SignInSlider(),
              SizedBox(height: 24),
              Text('Sign In', style: AppTextStyles.textLightTheme.displayLarge),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (String? t) => valid.validateEmail(t!),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          label: Text('Username/Email'),
                          hintText: emailHintText,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? p) => valid.validatePassword(p!),
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          label: Text('Password'),
                          hintText: passwordHintText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Forget Password?'),
                    TextButton(onPressed: () {}, child: Text('Click Here')),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: submitData,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary),
                  padding: WidgetStatePropertyAll(
                    EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: AppTextStyles.textDarkTheme.labelLarge,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Divider(thickness: 1.5),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 40,
                  children: [
                    IconButton(onPressed: () {}, icon: AppIcons.facebookSvg),
                    IconButton(onPressed: () {}, icon: AppIcons.xSvg),
                    IconButton(onPressed: () {}, icon: AppIcons.googleSvg),
                    IconButton(onPressed: () {}, icon: AppIcons.appleSvg),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(registerText),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(clickText),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text(helpButtonText)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
