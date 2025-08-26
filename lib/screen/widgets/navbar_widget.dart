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
      selectedIndex: currentIndex,
      onDestinationSelected: onTabSelected,
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
        NavigationDestination(
          icon: Icon(Icons.my_location_outlined),
          label: 'Locate',
        ),
        NavigationDestination(icon: Icon(Icons.token_outlined), label: 'Token'),
        NavigationDestination(
          icon: Icon(Icons.redeem_outlined),
          label: 'Redeem',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
