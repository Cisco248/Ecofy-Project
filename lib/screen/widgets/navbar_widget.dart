import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:e_wms_mobile/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const NavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.transparent,
      backgroundColor: AppColors.cardLight,
      selectedIndex: currentIndex,
      onDestinationSelected: onTabSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home_sharp,
            size: IconSize.size_32,
            color: currentIndex == 0 ? AppColors.success : Colors.grey,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.my_location_outlined,
            size: IconSize.size_32,
            color: currentIndex == 1 ? AppColors.success : Colors.grey,
          ),
          label: 'Locate',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.token_outlined,
            size: IconSize.size_32,
            color: currentIndex == 2 ? AppColors.success : Colors.grey,
          ),
          label: 'Token',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.redeem_outlined,
            size: IconSize.size_32,
            color: currentIndex == 3 ? AppColors.success : Colors.grey,
          ),
          label: 'Redeem',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_2_outlined,
            size: IconSize.size_32,
            color: currentIndex == 4 ? AppColors.success : Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
