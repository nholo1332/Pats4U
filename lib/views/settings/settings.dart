import 'package:flutter/material.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/constants.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/views/privacy_policy/privacy_policy.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: buildBody(),
        ),
      ),
    );
  }

  List<Widget> buildBody() {
    List<Widget> items = [];
    if ( Constants.userData.name != '' ) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                Constants.userData.name[0].toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              radius: 16,
            ),
            title: Text(Constants.userData.name),
            trailing: IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Logout',
              onPressed: () async {
                await Auth.signOut();
                setState(() { });
              }
            ),
          ),
        ),
      );
    }
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    items.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:  SizeConfig.blockSizeVertical * 2.2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Read our privacy policy to learn how your data is handled.',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 10,
        ),
        child: Row(
          children: [
            OutlinedButton(
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
    return items;
  }
}
