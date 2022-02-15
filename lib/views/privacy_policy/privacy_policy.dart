import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyState();
  }
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        height: 65,
        title: 'Privacy Policy',
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: buildBody(),
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
          height: 75,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/CLPats.png'),
                fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );
    items.add(
      Expanded(
        child: FutureBuilder(
          // Use a Future builder to load the privacy policy from file
          future: Future.delayed(
            const Duration(
              milliseconds: 150,
            ),
          ).then((value) {
            return rootBundle.loadString('assets/policies/privacy.md');
          }),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.data != null) {
              return Markdown(
                data: snapshot.data!,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 15,
      ),
    );
    return items;
  }
}
