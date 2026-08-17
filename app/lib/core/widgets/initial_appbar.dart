import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/logo.dart';

class InitialAppbar extends StatefulWidget implements PreferredSizeWidget {
  const InitialAppbar({super.key});

  @override
  State<InitialAppbar> createState() => _InitialAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _InitialAppbarState extends State<InitialAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      toolbarHeight: 50,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppLogo(element: whiteLogo),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 10,
            children: [
              DropdownButton<String>(
                onChanged: (value) {},
                iconSize: 20,
                borderRadius: BorderRadius.circular(10),
                focusColor: AppColors.primary,
                dropdownColor: Colors.white,
                items: [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'si', child: Text('සිංහල')),
                  DropdownMenuItem(value: 'ta', child: Text('தமிழ்')),
                ],
                icon: FaIcon(
                  FontAwesomeIcons.language,
                  color: AppColors.lightGray,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.moon,
                  size: 20,
                  color: AppColors.lightGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
