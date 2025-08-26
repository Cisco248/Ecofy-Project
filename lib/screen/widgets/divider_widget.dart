import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final dynamic textData;
  final dynamic numData;

  const DividerWidget({
    super.key,
    required this.textData,
    required this.numData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(textData, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 10),
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Divider(
              indent: 36,
              endIndent: 36,
              thickness: 2,
              radius: BorderRadius.circular(50),
            ),
            CircleAvatar(child: Text(numData)),
          ],
        ),
      ],
    );
  }
}
