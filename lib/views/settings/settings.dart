import 'package:flutter/material.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/classes_cache_manager.dart';
import 'package:pats4u/providers/constants.dart';
import 'package:pats4u/providers/events_cache_manager.dart';
import 'package:pats4u/providers/feed_cache_manager.dart';
import 'package:pats4u/providers/mascot_image_cache_provider.dart';
import 'package:pats4u/providers/menu_cache_manager.dart';
import 'package:pats4u/providers/menu_image_cache_manager.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/providers/staff_cache_manager.dart';
import 'package:pats4u/providers/staff_image_cache_manager.dart';
import 'package:pats4u/views/bug_report/bug_report.dart';
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
    if (Constants.userData.name != '') {
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
                  setState(() {});
                }),
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
                fontSize: SizeConfig.blockSizeVertical * 2.2,
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
              'Bug Report',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
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
                'Found a bug? Let us know so we can improve your app experience.',
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
                'Report Bug',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BugReport(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
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
              'Packages and Licenses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
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
                'View licenses of used packages and elements of this app.',
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
                'Licenses',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: 'Pats4U',
                  applicationVersion: Constants.packageInfo?.version ?? '',
                  applicationIcon: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 120,
                      minHeight: 120,
                      maxWidth: 120,
                      maxHeight: 120,
                    ),
                    child: Image.asset(
                      'assets/images/CLPats.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  applicationLegalese:
                      'Pats4U - created by Clarkson-Leigh FBLA '
                      'chapter Mobile Application Development group - Mitchel Beeson, '
                      'Noah Holoubek, and Samuel Pocasangre',
                );
              },
            ),
          ],
        ),
      ),
    );
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
              'Cache',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
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
                'The application cache allows data to be stored locally on the '
                    'device to make loading faster and data fetching while offline possible. '
                    'If you need to refresh the cache, clear the respective caches below. '
                    'If data errors are encountered, try clearing the respective cache below.',
                maxLines: 10,
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
                'Staff Cache',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Clearing cache...'),
                  ),
                );
                await ClassesCacheManager().emptyCache();
                await StaffCacheManager().emptyCache();
                await StaffImageCacheManager().emptyCache();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cache Cleared'),
                    duration: const Duration(
                      seconds: 3,
                    ),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          children: [
            OutlinedButton(
              child: Text(
                'Events Cache',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Clearing cache...'),
                  ),
                );
                await EventsCacheManager().emptyCache();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cache Cleared'),
                    duration: const Duration(
                      seconds: 3,
                    ),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          children: [
            OutlinedButton(
              child: Text(
                'Menu Cache',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Clearing cache...'),
                  ),
                );
                await MenuCacheManager().emptyCache();
                await MenuImageCacheManager().emptyCache();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cache Cleared'),
                    duration: const Duration(
                      seconds: 3,
                    ),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          children: [
            OutlinedButton(
              child: Text(
                'Feed Cache',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Clearing cache...'),
                  ),
                );
                await FeedCacheManager().emptyCache();
                await MascotImageCacheManager().emptyCache();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cache Cleared'),
                    duration: const Duration(
                      seconds: 3,
                    ),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    return items;
  }
}
