import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/logo.dart';
// import 'package:e_wms_mobile/provider/theme_provider.dart';
// import 'package:e_wms_mobile/utilities/services/theme_service.dart';
// import 'package:provider/provider.dart';

class InitialAppbar extends StatefulWidget implements PreferredSizeWidget {
  const InitialAppbar({super.key});

  @override
  State<InitialAppbar> createState() => _InitialAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _InitialAppbarState extends State<InitialAppbar> {
  // final ThemeMode _lightTheme = ThemeMode.light;
  // final ThemeMode _darkTheme = ThemeMode.dark;
  // ThemeMode currentTheme = ThemeMode.light; // default

  // bool isDark = false;

  // void toggleTheme() {
  //   if (isDark == false) {
  //     setState(() {
  //       currentTheme = _darkTheme;
  //       isDark = true;
  //     });
  //     print("Dark theme applied");
  //   } else {
  //     setState(() {
  //       currentTheme = _lightTheme;
  //       isDark = false;
  //     });
  //     print("Light theme applied");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ThemeProvider>(context);
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
                icon: Icon(
                  FontAwesomeIcons.language,
                  color: AppColors.lightGray,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  // provider.toggleTheme();
                },
                icon: Icon(
                  FontAwesomeIcons.circleHalfStroke,
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
