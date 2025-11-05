import 'package:e_wms_mobile/utilities/helpers/exception_helper.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:e_wms_mobile/core/constants/font.dart';
import 'package:e_wms_mobile/core/constants/size.dart';
import 'package:e_wms_mobile/core/constants/text.dart';
import 'package:e_wms_mobile/core/services/notification_service.dart';
import 'package:e_wms_mobile/feature/authentication/pages/signup_page.dart';
import 'package:e_wms_mobile/feature/authentication/widgets/custom_button.dart';
import 'package:e_wms_mobile/feature/authentication/widgets/initial_appbar.dart';
import 'package:e_wms_mobile/feature/authentication/widgets/sign_in_slider.dart';
import 'package:e_wms_mobile/feature/authentication/services/validator.dart';
import 'package:e_wms_mobile/feature/authentication/repository/auth_repo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var valid = Validator();

  void submitData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final loginUser = AuthSignInModel(
        userEmail: _emailController.text,
        userPassword: _passwordController.text,
      );

      final res = await AuthRemoteRepository().signIn(loginUser);

      final val = switch (res) {
        Left(value: final l) => l,
        Right(value: final r) => r.toString(),
      };

      if (!mounted) return;

      NotificationService(
        message: val.toString(),
        context: context,
      ).signInNotificationSuccess();
    } on AuthException catch (e) {
      NotificationService(
        message: e.message,
        context: context,
      ).signInNotificationError();
    } catch (e) {
      NotificationService(
        message: e.toString(),
        context: context,
      ).signInNotificationError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InitialAppbar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SignInSlider(),
              SizedBox(height: 24),
              Text("Sign In", style: AppTextStyles.textLightTheme.displayLarge),
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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
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
              CustomButton(
                label: 'Sign In',
                onPressed: () {
                  submitData();
                },
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        size: IconSize.size_32,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.xTwitter,
                        size: IconSize.size_32,
                        color: Colors.black,
                      ),
                    ), // Updated
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.google,
                        size: IconSize.size_32,
                        color: Colors.red,
                      ),
                    ), // Updated
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.apple,
                        size: IconSize.size_32,
                        color: Colors.black,
                      ),
                    ), // Updated
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                          child: Text(clickText),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: helpButtonText,
                        style: AppTextStyles.buttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
