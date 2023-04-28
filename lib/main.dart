import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/screens/auth_screens/account_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Text(
          "pokee",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 40,
            letterSpacing: 1,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        nextScreen:
            //FirebaseAuth.instance.currentUser == null
            AccountScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: PrimaryColor,
      ),
    );
  }
}
