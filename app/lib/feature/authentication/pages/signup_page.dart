import 'package:e_wms_mobile/core/constants/logo.dart';
import 'package:e_wms_mobile/utilities/helpers/exception_helper.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:e_wms_mobile/core/services/notification_service.dart';
import 'package:e_wms_mobile/feature/authentication/services/validator.dart';
import 'package:e_wms_mobile/feature/authentication/widgets/divider_widget.dart';
import 'package:e_wms_mobile/feature/authentication/repository/auth_repo.dart';
import 'package:flutter/material.dart';

final validator = Validator();
final signupFunction = AuthRemoteRepository();
int currentStep = 0;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final PageController _pageController = PageController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  void setStep(int step) {
    setState(() {
      currentStep += 1;
    });
  }

  void _nextPage() {
    if (_formKeys[currentStep].currentState!.validate()) {
      _formKeys[currentStep].currentState!.save();

      if (currentStep < 2) {
        setStep(currentStep + 1);
        _pageController.animateToPage(
          currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submit();
      }
    }
  }

  void _previousPage() {
    if (currentStep > 0) {
      setStep(currentStep - 1);
      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submit() async {
    try {
      final signUpUser = AuthSignUpSchema(
        userFirstName: _firstNameController.text,
        userLastName: _lastNameController.text,
        userEmail: _emailController.text,
        userPassword: _passwordController.text,
        userConfirmPassword: _confirmPasswordController.text,
        userMobileNum: 0,
      );
      await signupFunction.signUp(signUpUser);
      if (!mounted) return;
      NotificationService(
        message: "Signup Successful!",
        context: context,
      ).signUpNotificationSuccess();
    } on AuthException catch (e) {
      NotificationService(
        message: e.message,
        context: context,
      ).signUpNotificationError();
    } catch (e) {
      NotificationService(
        message: e.toString(),
        context: context,
      ).signUpNotificationError();
    }
  }

  String? nameChanger() {
    if (currentStep == 0) {
      return 'Enter Your Name';
    } else if (currentStep == 1) {
      return 'Enter Your Email';
    } else {
      return 'Create New Password';
    }
  }

  String? numberChanger() {
    if (currentStep == 0) {
      return '1';
    } else if (currentStep == 1) {
      return '2';
    } else {
      return '3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(element: logoLarge, svgWidth: 120, svgHeight: 75),
            DividerWidget(textData: nameChanger(), numData: numberChanger()),
            Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SignupStepName(
                    formNameKey: _formKeys[0],
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                  ),
                  SignupStepEmail(
                    formEmailKey: _formKeys[1],
                    emailController: _emailController,
                  ),
                  SignupStepPassword(
                    formPasswordKey: _formKeys[2],
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousPage,
                    child: const Text("Back"),
                  ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(currentStep == 2 ? "Submit" : "Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignupStepName extends StatelessWidget {
  final GlobalKey<FormState> formNameKey;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  SignupStepName({
    super.key,
    required this.formNameKey,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formNameKey,
      child: Column(
        spacing: 20,
        children: [
          TextFormField(
            controller: firstNameController,
            validator: validator.validateRequirement,
            decoration: InputDecoration(
              labelText: "First Name*",
              hintText: 'E.g: John',
            ),
          ),
          TextFormField(
            controller: lastNameController,
            validator: validator.validateRequirement,
            decoration: InputDecoration(
              labelText: "Last Name*",
              hintText: 'E.g: Doe',
            ),
          ),
        ],
      ),
    );
  }
}

class SignupStepEmail extends StatelessWidget {
  final GlobalKey<FormState> formEmailKey;
  TextEditingController emailController = TextEditingController();

  SignupStepEmail({
    super.key,
    required this.formEmailKey,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formEmailKey,
      child: TextFormField(
        controller: emailController,
        validator: (String? value) => validator.validateEmail(value!),
        decoration: InputDecoration(
          labelText: "Email",
          hintText: 'E.g: johndoe@example.com',
        ),
      ),
    );
  }
}

class SignupStepPassword extends StatelessWidget {
  final GlobalKey<FormState> formPasswordKey;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SignupStepPassword({
    super.key,
    required this.formPasswordKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formPasswordKey,
      child: Column(
        spacing: 20,
        children: [
          TextFormField(
            controller: passwordController,
            validator: (pwd) => validator.validatePassword(pwd!),
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: 'E.g: *********',
            ),
          ),

          TextFormField(
            controller: confirmPasswordController,
            validator: (pwd) => validator.validatePassword(pwd!),
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: 'E.g: *********',
            ),
          ),
        ],
      ),
    );
  }
}
