import 'package:flutter/material.dart';
import 'package:pats4u/models/staff_member.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:pats4u/widgets/staff_item.dart';

class Staff extends StatefulWidget {
  const Staff({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Staff();
  }
}

class _Staff extends State<Staff> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinimalAppBar(
        height: 65,
      ),
      body: FutureBuilder(
        future: Backend.getStaffMembers(),
        builder: (context, AsyncSnapshot<List<StaffMember>> snapshot) {
          if ( snapshot.connectionState == ConnectionState.done && snapshot.data != null ) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: getStaff(snapshot.data!),
                ),
              )
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
        },
      )
    );
  }

  getStaff(List<StaffMember> staff) {
    List<Widget> items = [];
    items.addAll(
      List.generate(
        staff.length + 20,
            (index) => StaffItem(
          staffMember: staff[0],
          onTap: () {
            print('click');
          },
        ),
      ),
    );
    items.add(
      const SizedBox(height: 100),
    );
    return items;
  }
}
