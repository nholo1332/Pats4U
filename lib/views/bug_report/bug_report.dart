import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pats4u/models/bug_report_model.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class BugReport extends StatefulWidget {
  const BugReport({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BugReportState();
  }
}

class _BugReportState extends State<BugReport> {
  bool loading = false;
  BugReportModel bugReportModel = BugReportModel();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  IosDeviceInfo? iosInfo;
  AndroidDeviceInfo? androidInfo;

  @override
  void initState() {
    super.initState();
    // Fetch current platform data
    if (Platform.isIOS) {
      deviceInfo.iosInfo.then((value) {
        setState(() {
          iosInfo = value;
        });
      });
    } else if (Platform.isAndroid) {
      deviceInfo.androidInfo.then((value) {
        setState(() {
          androidInfo = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the view body
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MinimalAppBar(
        title: 'Bug Report',
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.pop(context);
        },
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report a Bug',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2.8,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? 'assets/images/account_line.png'
                            : 'assets/images/account_line_darkmode.png',
                        width: 99,
                        height: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: bugReportModel.location,
                            autocorrect: true,
                            onChanged: (value) {
                              bugReportModel.location = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Bug Location',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: bugReportModel.description,
                            autocorrect: true,
                            maxLines: 3,
                            onChanged: (value) {
                              bugReportModel.description = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Bug Description',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: bugReportModel.reproductionSteps,
                            autocorrect: true,
                            maxLines: 5,
                            onChanged: (value) {
                              bugReportModel.reproductionSteps = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Reproduction Steps',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(getDeviceInfoText()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: loading ? null : report,
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.onPrimary),
                                )
                              : Text(
                                  'Send',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  report() {
    // Check report form and send bug report
    if (bugReportModel.location != '' &&
        bugReportModel.description != '' &&
        bugReportModel.reproductionSteps != '' &&
        !loading) {
      setState(() {
        loading = true;
      });
      bugReportModel.deviceInfo = getDeviceInfoText();
      Backend.reportBug(bugReportModel).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitted bug report!'),
            duration: Duration(
              seconds: 3,
            ),
          ),
        );
        Navigator.of(context).pop();
      }).catchError((error) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to send bug report.'),
            duration: const Duration(
              seconds: 3,
            ),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      });
    } else if (!loading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill out all fields'),
          duration: const Duration(
            seconds: 3,
          ),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  String getDeviceInfoText() {
    // Get device platform information in a compiled String format
    if (Platform.isIOS && iosInfo != null) {
      return 'iOS; ' +
          (iosInfo?.utsname.machine ?? '') +
          '-' +
          (iosInfo?.systemVersion ?? '');
    } else if (Platform.isAndroid && androidInfo != null) {
      return 'Android; ' +
          (androidInfo?.device ?? '') +
          ',' +
          (androidInfo?.model ?? '') +
          '-' +
          (androidInfo?.version.baseOS ?? '') +
          '.' +
          (androidInfo?.version.release ?? '');
    } else {
      return '';
    }
  }
}
