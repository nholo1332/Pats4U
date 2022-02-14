import 'package:flutter/material.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFeedState();
  }
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinimalAppBar(
        height: 65,
        title: 'Patriot Feed',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(),
    );
  }
}
