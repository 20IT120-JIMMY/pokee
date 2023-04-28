import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Home Screen",style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 25,
          fontWeight: FontWeight.w500
        ),
        ),
      ),
    );
  }
}
