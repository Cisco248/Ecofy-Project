import 'package:e_wms_mobile/provider/appbar_provider.dart';
// import 'package:e_wms_mobile/provider/signing_provider.dart';
import 'package:e_wms_mobile/screen/pages/landing_page.dart';
import 'package:e_wms_mobile/screen/pages/locate_page.dart';
import 'package:e_wms_mobile/screen/pages/profile_page.dart';
import 'package:e_wms_mobile/screen/pages/redeem_page.dart';
import 'package:e_wms_mobile/screen/pages/token_page.dart';
import 'package:e_wms_mobile/screen/widgets/navbar_widget.dart';
import 'package:e_wms_mobile/utilities/constants/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    } else if (currentIndex == 3) {
      return Center(child: RedeemPage());
    } else {
      return Center(child: ProfilePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppBarProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppLogo(),
        ),
        leadingWidth: 75,
        toolbarHeight: 75,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              spacing: 10,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.setGreeting(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      provider.setUsername(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('lib/assets/images/ravi.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
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
