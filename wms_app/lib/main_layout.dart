import 'package:wms_app/core/widgets/appbar_widget.dart';
import 'package:wms_app/core/widgets/navbar_widget.dart';
import 'package:wms_app/feature/discover/views/locate_page.dart';
import 'package:wms_app/feature/profile/views/profile_page.dart';
import 'package:wms_app/feature/token/views/token_page.dart';
import 'feature/landing/views/landing_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentIndex = 0;
  Widget navigationLink() {
    if (currentIndex == 0) {
      return Center(child: LandingPage());
    } else if (currentIndex == 1) {
      return Center(child: LocateBinPage());
    } else if (currentIndex == 2) {
      return Center(child: TokenGeneratePage());
    } else {
      return Center(child: ProfilePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: navigationLink(),
      bottomNavigationBar: NavBarWidget(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
