import 'package:flutter/material.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/constants.dart';
import 'package:pats4u/providers/events_cache_manager.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/views/register/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool loading = false;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build login view
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
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
                      Ink(
                        decoration: ShapeDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left),
                          color: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Login to your\naccount',
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
                            initialValue: email,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Email',
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
                            initialValue: password,
                            obscureText: true,
                            autocorrect: false,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Password',
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
                    height: 32,
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
                        onTap: loading ? null : login,
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.onPrimary),
                                )
                              : Text(
                                  'Login',
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
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need an account? ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: SizeConfig.blockSizeVertical * 1.8,
                        ),
                      ),
                      GestureDetector(
                        onTap: loading
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                          ),
                        ),
                      ),
                    ],
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

  login() {
    // Check form and sign user in. If successful, pull their data
    if (email != '' && password != '' && !loading) {
      setState(() {
        loading = true;
      });
      Auth.login(email, password).then((value) async {
        await EventsCacheManager().emptyCache();
        return Backend.getUserData(force: true);
      }).then((value) {
        Constants.userData = value;
        Navigator.of(context).pop(true);
      }).catchError((error) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to login with credentials'),
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
          content: const Text('Please enter an email and password'),
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
}
