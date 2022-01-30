import 'package:flutter/material.dart';
import 'package:pats4u/manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void fetchData() async {
    // Fetch app information
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Manager(),
      ),
    );
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(),
    );
  }

}
