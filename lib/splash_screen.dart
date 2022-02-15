import 'package:flutter/material.dart';
import 'package:pats4u/manager.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void fetchData() {
    // Fetch user information
    Constants().init();
    if ( Auth.getUser() != null ) {
      Backend.getUserData().then((value) {
        Constants.userData = value;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const Manager(),
          ),
        );
      }).catchError((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load user data'),
            duration: Duration(
              seconds: 3,
            ),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const Manager(),
          ),
        );
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Manager(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Because Firebase auth will immediately return the auth state, we must
    // wait for the view to load to prevent moving to another view
    // before the current is loaded
    WidgetsBinding.instance?.addPostFrameCallback((_) => fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: 175,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/CLPats.png'),
                  fit: BoxFit.fitHeight
              ),
            ),
          ),
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
