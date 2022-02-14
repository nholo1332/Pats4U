import 'package:flutter/material.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        height: 65,
        title: 'Settings',
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(),
    );
  }
}
