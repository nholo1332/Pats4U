import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pats4u/splash_screen.dart';
import 'package:pats4u/themes/dark_theme.dart';
import 'config/firebase_options.dart';
import 'package:pats4u/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Pats4U());
}

class Pats4U extends StatelessWidget {
  const Pats4U({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pats4U',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const SplashScreen(),
    );
  }
}