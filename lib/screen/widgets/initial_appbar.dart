import 'package:e_wms_mobile/utilities/constants/logo.dart';
import 'package:flutter/material.dart';

class InitialAppbar extends StatefulWidget {
  const InitialAppbar({super.key});

  @override
  State<InitialAppbar> createState() => _InitialAppbarState();
}

class _InitialAppbarState extends State<InitialAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leading: AppLogo(svgWidth: 150, svgHeight: 50),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.language_rounded, size: 32),
          mouseCursor: MouseCursor.defer,
        ),
      ],
    );
  }
}
