import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wms_app/core/constants/font.dart';
import 'package:wms_app/core/constants/size.dart';
import 'package:wms_app/core/constants/text.dart';
import 'package:wms_app/main_layout.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';
import 'package:wms_app/utilities/services/notification_service.dart';
import 'package:wms_app/utilities/services/validator.dart';
import 'package:wms_app/core/widgets/custom_button.dart';
import 'package:wms_app/core/widgets/initial_appbar.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/core/widgets/sign_in_slider.dart';
import 'package:wms_app/feature/auth/viewmodels/auth_view_model.dart';
import 'package:wms_app/feature/auth/views/sign_up_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var valid = Validator();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // import the authViewModelProvider for the page, setup the State using Provider
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    DebugPrint(isLoading, '[SIGN IN] View Status').log();
    // Mange the State the using the authViewModelProvider
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          NotificationService.instance.show(
            context: context,
            message: 'Login Successfull!, ${data.email}',
            type: NotificationType.success,
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainWrapper()),
          );
        },
        error: (error, st) {
          NotificationService.instance.show(
            context: context,
            message: error.toString(),
            type: NotificationType.error,
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: InitialAppbar(),
      body: isLoading
          ? Loader()
          : SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SignInSlider(),
                    SizedBox(height: 24),
                    Text(
                      "Sign In",
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
                              validator: (String? p) =>
                                  valid.validatePassword(p!),
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
                          TextButton(
                            onPressed: () {},
                            child: Text('Click Here'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: 'Sign In',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Call the remote repository task for the signup page
                          // Read the Function parameters using notifier
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signInUser(
                                userEmail: _emailController.text,
                                userPassword: _passwordController.text,
                              );
                        } else {
                          NotificationService.instance.show(
                            context: context,
                            message: "Valadation Failed, Try Again!",
                            type: NotificationType.error,
                          );
                        }
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
