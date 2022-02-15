import 'package:flutter/material.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/constants.dart';
import 'package:pats4u/providers/events_cache_manager.dart';
import 'package:pats4u/providers/size_config.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  bool loading = false;
  String name = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
                        'Register an\naccount',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2.8,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/account_line.png',
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
                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: name,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Full Name',
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
                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: email,
                            keyboardType: TextInputType.emailAddress,
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
                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            enabled: !loading,
                            initialValue: password,
                            obscureText: true,
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
                        onTap: loading
                            ? null
                            : register,
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary),
                          )
                              : Text(
                            'Register',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
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
                        'Have an account? ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: SizeConfig.blockSizeVertical * 1.8,
                        ),
                      ),
                      GestureDetector(
                        onTap: loading
                            ? null
                            : () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
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

  register() {
    if ( name != '' && email != '' && password != '' && !loading ) {
      setState(() {
        loading = true;
      });
      Auth.register(email, password).then((value) async {
        await EventsCacheManager().emptyCache();
        return Backend.registerAccount(name);
      }).then((value) {
        Constants.userData = value;
        Navigator.of(context)
          ..pop()
          ..pop();
      }).catchError((error) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to register with credentials'),
            duration: const Duration(
              seconds: 3,
            ),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () { },
            ),
          ),
        );
      });
    } else if ( !loading ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a name, email, and password'),
          duration: const Duration(
            seconds: 3,
          ),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () { },
          ),
        ),
      );
    }
  }
}