import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/logo.dart';
import 'package:wms_app/core/providers/current_profile_notifier.dart';

class AppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            color: AppColors.bgLight,
            iconSize: 36,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      toolbarHeight: 75,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(whiteLogo),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            spacing: 2,
            children: [
              IconButton(
                onPressed: () {
                  ref.refresh(currentProfileProvider.notifier).logOut();
                },
                icon: Icon(Icons.logout),
                color: AppColors.appBgLight,
                iconSize: 28,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
