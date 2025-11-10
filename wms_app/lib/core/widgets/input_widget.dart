// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final Icon textIcons;
  final bool secureText;
  late TextEditingController controller = TextEditingController();
  late FormFieldValidator<String> valid;

  AppInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.errorText,
    required this.textIcons,
    this.secureText = false,
    required this.valid,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 80,
      child: TextFormField(
        controller: widget.controller,
        maxLines: 1,
        style: Theme.of(context).textTheme.labelSmall,
        validator: widget.valid,
        obscureText: widget.secureText,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
