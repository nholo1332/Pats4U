import 'package:flutter/material.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFeed();
  }
}

class _HomeFeed extends State<HomeFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(),
    );
  }
}
