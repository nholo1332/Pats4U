import 'package:flutter/material.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class LunchMenu extends StatefulWidget {
  const LunchMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LunchMenuState();
  }
}

class _LunchMenuState extends State<LunchMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinimalAppBar(
        height: 65,
        title: 'Lunch Menu',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(),
    );
  }
}
