import 'package:flutter/material.dart';

class TextDividerWidget extends StatelessWidget {
  final String text;
  const TextDividerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
        ],
      ),
    );
  }
}
