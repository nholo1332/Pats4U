import 'package:flutter/material.dart';
import 'package:pats4u/views/settings/settings.dart';
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
      appBar: MinimalAppBar(
        height: 65,
        title: 'Patriot Feed',
        leftIcon: Icons.settings,
        leftAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: buildBody(),
        ),
      ),
    );
  }

  List<Widget> buildBody() {
    List<Widget> items = [];
    items.add(
      Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/CLPats.png'),
                fit: BoxFit.fitHeight
            ),
          ),
        ),
      ),
    );
    return items;
  }
}
