import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/pages/about.dart';
import 'package:wms_app/core/pages/complaint.dart';
import 'package:wms_app/core/pages/contact.dart';
import 'package:wms_app/core/pages/help.dart';
import 'package:wms_app/core/pages/setting.dart';
import 'package:wms_app/core/pages/support.dart';
import 'package:wms_app/core/widgets/appbar_widget.dart';
import 'package:wms_app/core/widgets/navbar_widget.dart';
import 'package:wms_app/feature/discover/views/discover_page.dart';
import 'package:wms_app/feature/profile/views/profile_page.dart';
import 'package:wms_app/feature/token/views/token_page.dart';
import 'feature/landing/views/landing_page.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;

Widget navigationLink() {
  switch (currentIndex) {
    case 0:
      return LandingPage();
    case 1:
      return DiscoverPage();
    case 2:
      return TokenGeneratePage();
    case 3:
    default:
      return ProfilePage();
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Center(
                child: Text(
                  'G - Disposal Waste',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.appBgLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text(
                  'Support Us',
                  selectionColor: AppColors.focus,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportPage()),
                );
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('Contact Us'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('Help'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('Complaints'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintPage()),
                );
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('About Us'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('Settings'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
          ],
        ),
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
