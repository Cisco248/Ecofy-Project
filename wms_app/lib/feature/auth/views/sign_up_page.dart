import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/core/constants/logo.dart';
import 'package:wms_app/utilities/services/notification_service.dart';
import 'package:wms_app/utilities/services/validator.dart';
import 'package:wms_app/core/widgets/divider_widget.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/feature/auth/viewmodels/auth_view_model.dart';
import 'package:wms_app/feature/auth/views/sign_in_page.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final PageController _pageController = PageController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  final _validator = Validator();
  int _currentStep = 0;

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Enter Your Name';
      case 1:
        return 'Enter Your Email';
      case 2:
        return 'Create New Password';
      case 3:
        return 'Enter Your Mobile Number';
      default:
        return '';
    }
  }

  String _getStepNumber() {
    return '${_currentStep + 1}';
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleNext() async {
    if (_formKeys[_currentStep].currentState!.validate()) {
      _formKeys[_currentStep].currentState!.save();

      if (_currentStep < 3) {
        _goToStep(_currentStep + 1);
      } else {
        if (_formKeys[_currentStep].currentState!.validate()) {
          // Call the remote repository task for the signup page
          // Read the Function parameters using notifier
          await ref
              .read(authViewModelProvider.notifier)
              .signUpUser(
                userFistName: _firstNameController.text,
                userLastName: _lastNameController.text,
                userEmail: _emailController.text,
                userPassword: _passwordController.text,
                userConfirmPassword: _confirmPasswordController.text,
                userMobileNum: _mobileNumberController.text,
              );
        }
      }
    }
  }

  void _handleBack() {
    if (_currentStep > 0) {
      _goToStep(_currentStep - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set logic for the Loading Screen
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    // Set the Nevigate the Login Page when Submitted the form data
    // manage the page state using the authViewModelProvider
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          NotificationService.instance.show(
            context: context,
            message: 'Registration Successfull: ${data.email}',
            type: NotificationType.success,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        error: (error, st) {
          NotificationService.instance.show(
            context: context,
            message: error.toString(),
            type: NotificationType.error,
          );
          return null;
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo(element: logoLarge, svgWidth: 120, svgHeight: 75),
                  DividerWidget(
                    textData: _getStepTitle(),
                    numData: _getStepNumber(),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 250),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: PageView(
                        clipBehavior: Clip.none,
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SignupStepName(
                            formNameKey: _formKeys[0],
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            validator: _validator,
                          ),
                          SignupStepEmail(
                            formEmailKey: _formKeys[1],
                            emailController: _emailController,
                            validator: _validator,
                          ),
                          SignupStepPassword(
                            formPasswordKey: _formKeys[2],
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            validator: _validator,
                          ),
                          SignupStepMobile(
                            formMobileKey: _formKeys[3],
                            mobileNumberController: _mobileNumberController,
                            validator: _validator,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (_currentStep > 0)
                        ElevatedButton(
                          onPressed: _handleBack,
                          child: const Text("Back"),
                        ),
                      ElevatedButton(
                        onPressed: _handleNext,
                        child: Text(_currentStep == 3 ? "Submit" : "Next"),
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
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final Validator validator;

  const SignupStepName({
    super.key,
    required this.formNameKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.validator,
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
  final TextEditingController emailController;
  final Validator validator;

  const SignupStepEmail({
    super.key,
    required this.formEmailKey,
    required this.emailController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formEmailKey,
      child: TextFormField(
        controller: emailController,
        validator: (String? value) => validator.validateEmail(value!),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email*",
          hintText: 'E.g: johndoe@example.com',
        ),
      ),
    );
  }
}

class SignupStepPassword extends StatelessWidget {
  final GlobalKey<FormState> formPasswordKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Validator validator;

  const SignupStepPassword({
    super.key,
    required this.formPasswordKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.validator,
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
              labelText: "Password*",
              hintText: 'E.g: *********',
            ),
          ),
          TextFormField(
            controller: confirmPasswordController,
            validator: (pwd) {
              if (pwd != passwordController.text) {
                return 'Passwords do not match';
              }
              return validator.validatePassword(pwd!);
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password*",
              hintText: 'E.g: *********',
            ),
          ),
        ],
      ),
    );
  }
}

class SignupStepMobile extends StatelessWidget {
  final GlobalKey<FormState> formMobileKey;
  final TextEditingController mobileNumberController;
  final Validator validator;

  const SignupStepMobile({
    super.key,
    required this.formMobileKey,
    required this.mobileNumberController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formMobileKey,
      child: Column(
        spacing: 20,
        children: [
          TextFormField(
            controller: mobileNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mobile number is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Mobile Number*",
              hintText: 'E.g: 0771234567',
            ),
          ),
        ],
      ),
    );
  }
}
