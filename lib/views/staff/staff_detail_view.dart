import 'package:flutter/material.dart';
import 'package:pats4u/models/class.dart';
import 'package:pats4u/models/staff_member.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:pats4u/widgets/profile_image.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffDetailView extends StatefulWidget {
  final StaffMember staffMember;

  const StaffDetailView({
    required this.staffMember,
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StaffDetailView();
  }
}

class _StaffDetailView extends State<StaffDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        height: 65,
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: buildBody(),
          ),
        ),
      ),
    );
  }

  buildBody() {
    List<Widget> items = [];
    items.add(
      Center(
        child: ProfileImage(
          image: widget.staffMember.picture,
          radius: 100,
          height: 200,
          width: 200,
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.staffMember.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 3,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: Backend.getClasses(),
              builder: (context, AsyncSnapshot<List<Class>> snapshot) {
                if ( snapshot.connectionState == ConnectionState.done && snapshot.data != null ) {
                  return Row(
                    children: List.generate(
                      widget.staffMember.classes.length,
                      (index) {
                        return Chip(
                          label: Text(
                            ((snapshot.data ?? []).firstWhere((c) => c.id == widget.staffMember.classes[index], orElse: () => Class())).title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary
                            ),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Bio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:  SizeConfig.blockSizeVertical * 2.2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: SizeConfig.screenWidth - 90,
                  ),
                  child: Text(
                    widget.staffMember.bio,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Contact',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:  SizeConfig.blockSizeVertical * 2.2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if ( widget.staffMember.email != '' ) Row(
              children: [
                const Icon(
                  Icons.email,
                ),
                TextButton(
                  onPressed: () async {
                    if ( await canLaunch('mailto:' + widget.staffMember.email) ) {
                      launch('mailto:' + widget.staffMember.email);
                    }
                  },
                  child: Text(
                    widget.staffMember.email,
                  ),
                )
              ],
            ),
            if ( widget.staffMember.phone != '' ) Row(
              children: [
                const Icon(
                  Icons.call,
                ),
                TextButton(
                  onPressed: () async {
                    if ( await canLaunch('tel:' + widget.staffMember.phone) ) {
                      launch('tel:' + widget.staffMember.phone);
                    }
                  },
                  child: Text(
                    widget.staffMember.phone,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    if ( widget.staffMember.hobbies.isNotEmpty || widget.staffMember.funFacts.isNotEmpty ) {
      items.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 45,
            left: 25,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Get to Know ' + widget.staffMember.name.split(' ').first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:  SizeConfig.blockSizeVertical * 2.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              if ( widget.staffMember.hobbies.isNotEmpty ) Row(
                children: [
                  Text(
                    'Hobbies',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:  SizeConfig.blockSizeVertical * 2.2,
                    ),
                  ),
                ],
              ),
              if ( widget.staffMember.hobbies.isNotEmpty ) Row(
                children: List.generate(
                  widget.staffMember.hobbies.length,
                  (index) => Expanded(
                    child: ListTile(
                      leading: Icon(
                        widget.staffMember.hobbies[index].icon != 0
                          ? IconData(widget.staffMember.hobbies[index].icon)
                          : Icons.star,
                      ),
                      title: Text(
                        widget.staffMember.hobbies[index].title,
                      ),
                      subtitle: Text(
                          widget.staffMember.hobbies[index].description,
                      ),
                      onTap: () {
                        openInfoDialog(
                          widget.staffMember.hobbies[index].title + ' - Hobby',
                          widget.staffMember.hobbies[index].description,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if ( widget.staffMember.funFacts.isNotEmpty ) Row(
                children: [
                  Text(
                    'Fun Facts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:  SizeConfig.blockSizeVertical * 2.2,
                    ),
                  ),
                ],
              ),
              if ( widget.staffMember.funFacts.isNotEmpty ) Row(
                children: List.generate(
                  widget.staffMember.funFacts.length,
                  (index) => Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.star_rate,
                      ),
                      title: Text(
                        widget.staffMember.funFacts[index].title,
                      ),
                      subtitle: Text(
                        widget.staffMember.funFacts[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        openInfoDialog(
                          widget.staffMember.funFacts[index].title + ' - Fun Fact',
                          widget.staffMember.funFacts[index].description,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      );
    }
    return items;
  }

  openInfoDialog(String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}