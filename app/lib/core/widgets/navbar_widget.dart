import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/size.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const NavBarWidget({
    super.key,
    required this.onTabSelected,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = AppColors.lightGray;
    final Color selectedColor = AppColors.primary;

    return NavigationBar(
      indicatorColor: Colors.transparent,
      selectedIndex: currentIndex,
      onDestinationSelected: onTabSelected,
      destinations: [
        IconButton(
          icon: Icon(
            Icons.house_rounded,
            size: IconSize.size_28,
            color: currentIndex == 0 ? selectedColor : unselectedColor,
          ),
          onPressed: () => onTabSelected(0),
        ),
        IconButton(
          icon: Icon(
            Icons.map,
            size: IconSize.size_28,
            color: currentIndex == 1 ? selectedColor : unselectedColor,
          ),
          onPressed: () => onTabSelected(1),
        ),
        IconButton(
          icon: Icon(
            Icons.airplane_ticket,
            size: IconSize.size_28,
            color: currentIndex == 2 ? selectedColor : unselectedColor,
          ),
          onPressed: () => onTabSelected(2),
        ),
        IconButton(
          icon: Icon(
            Icons.person,
            size: IconSize.size_28,
            color: currentIndex == 3 ? selectedColor : unselectedColor,
          ),
          onPressed: () => onTabSelected(3),
        ),
      ],
    );
  }
}
