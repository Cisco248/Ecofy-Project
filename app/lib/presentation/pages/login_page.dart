import 'package:e_wms_mobile/core/provider/auth_provider.dart';
import 'package:e_wms_mobile/data/utilities/database/translate_database.dart';
import 'package:e_wms_mobile/core/constants/color.dart';
import 'package:e_wms_mobile/core/constants/font.dart';
import 'package:e_wms_mobile/core/constants/size.dart';
import 'package:e_wms_mobile/core/constants/text.dart';
import 'package:e_wms_mobile/presentation/widgets/initial_appbar.dart';
import 'package:e_wms_mobile/presentation/widgets/sign_in_slider.dart';
import 'package:e_wms_mobile/data/utilities/services/notification_service.dart';
import 'package:e_wms_mobile/data/utilities/services/validator.dart';
import 'package:e_wms_mobile/repository/auth_repo.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final loginRepository = AuthRemoteRepository();

  late final email = _emailController.text;
  late final password = _passwordController.text;

  var valid = Validator();

  late final provider = Provider.of<AuthProvider>(context, listen: false);

  void submitData() async {
    if (_formKey.currentState!.validate()) {
      await loginRepository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      try {
        NotificationService(
          message: signInTextSuccess,
          context: context,
        ).signInNotificationSuccess();
        Navigator.pushNamed(context, '/home');
      } catch (e) {
        NotificationService(
          message: signInTextFailed,
          context: context,
        ).signInNotificationError();
      }
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
              Text(
                TranslateDatabase.title.getString(context),
                style: AppTextStyles.textLightTheme.displayLarge,
              ),
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
              Container(
                width: 330,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: submitData,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    padding: WidgetStatePropertyAll(
                      EdgeInsetsGeometry.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyles.textDarkTheme.labelLarge,
                  ),
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
