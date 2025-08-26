import 'package:flutter/material.dart';

class TextDividerWidget extends StatelessWidget {
  final String text;
  const TextDividerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
