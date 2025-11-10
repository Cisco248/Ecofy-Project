import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/core/constants/font.dart';
import 'package:wms_app/core/constants/logo.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(whiteLogo),
      ),
      leadingWidth: 90,
      toolbarHeight: 75,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            spacing: 10,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "",
                    textAlign: TextAlign.end,
                    style: AppTextStyles.appBarText.titleLarge,
                  ),
                  Text(
                    '',
                    textAlign: TextAlign.end,
                    style: AppTextStyles.appBarText.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
