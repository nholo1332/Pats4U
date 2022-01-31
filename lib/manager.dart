import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pats4u/views/calendar/calendar.dart';
import 'package:pats4u/views/home_feed/home_feed.dart';
import 'package:pats4u/views/settings/settings.dart';
import 'package:pats4u/views/staff/staff.dart';

class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManagerState();
  }
}

class _ManagerState extends State<Manager> {
  // Create tabs for navigation tab bar
  int currentTabIndex = 0;
  final List<Widget> tabChildren = [
    const HomeFeed(),
    const Calendar(),
    const Staff(),
    const Settings(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create the scaffold to hold the bottom navigation bar
    return Scaffold(
      body: tabChildren[currentTabIndex],
      /*IndexedStack(
        index: currentTabIndex,
        children: tabChildren,
      ),*/
      bottomNavigationBar: CustomNavigationBar(
        isFloating: true,
        borderRadius: const Radius.circular(16),
        onTap: onTabTapped,
        currentIndex: currentTabIndex,
        backgroundColor: Colors.black,
        unSelectedColor: Colors.white60,
        selectedColor: Colors.white,
        iconSize: 30,
        items: [
          CustomNavigationBarItem(
            selectedIcon: Image.asset('assets/images/CLPats.png'),
            icon: Image.asset('assets/images/CLPats_grey.png'),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.checklist),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.badge),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  // Switch the current tab to the selected index
  void onTabTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}
