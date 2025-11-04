import 'package:e_wms_mobile/core/constants/logo.dart';
import 'package:e_wms_mobile/core/provider/auth_provider.dart';
import 'package:e_wms_mobile/data/utilities/services/validator.dart';
import 'package:e_wms_mobile/presentation/widgets/divider_widget.dart';
import 'package:e_wms_mobile/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final validator = Validator();
final signupFunction = AuthRemoteRepository();

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

  late final provider = Provider.of<AuthProvider>(context, listen: false);

  void _nextPage() {
    if (_formKeys[provider.currentStep].currentState!.validate()) {
      _formKeys[provider.currentStep].currentState!.save();

      if (provider.currentStep < 2) {
        provider.setStep(provider.currentStep + 1);
        _pageController.animateToPage(
          provider.currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submit();
      }
    }
  }

  void _previousPage() {
    if (provider.currentStep > 0) {
      provider.setStep(provider.currentStep - 1);
      _pageController.animateToPage(
        provider.currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submit() async {
    await signupFunction.signUp(
      fname: _firstNameController.text,
      lname: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmpassword: _confirmPasswordController.text,
      mobilenum: "hello",
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Signup Successful!")));
  }

  String? nameChanger() {
    if (provider.currentStep == 0) {
      return 'Enter Your Name';
    } else if (provider.currentStep == 1) {
      return 'Enter Your Email';
    } else {
      return 'Create New Password';
    }
  }

  String? numberChanger() {
    if (provider.currentStep == 0) {
      return '1';
    } else if (provider.currentStep == 1) {
      return '2';
    } else {
      return '3';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
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
                if (provider.currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousPage,
                    child: const Text("Back"),
                  ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(provider.currentStep == 2 ? "Submit" : "Next"),
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
