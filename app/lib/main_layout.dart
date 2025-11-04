import 'package:e_wms_mobile/presentation/pages/landing_page.dart';
import 'package:e_wms_mobile/presentation/pages/locate_page.dart';
import 'package:e_wms_mobile/presentation/pages/profile_page.dart';
import 'package:e_wms_mobile/presentation/pages/token_page.dart';
import 'package:e_wms_mobile/presentation/widgets/appbar_widget.dart';
import 'package:e_wms_mobile/presentation/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
// import 'package:e_wms_mobile/provider/appbar_provider.dart';
// import 'package:e_wms_mobile/utilities/constants/logo.dart';
// import 'package:provider/provider.dart';

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
    // final provider = Provider.of<AppBarProvider>(context, listen: false);
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
