import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

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
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create the scaffold to hold the bottom navigation bar
    return Scaffold(
      body: tabChildren[currentTabIndex], /*IndexedStack(
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
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.home),
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