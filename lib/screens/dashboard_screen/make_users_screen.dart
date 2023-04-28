import 'package:flutter/material.dart';

class MakeUserScreen extends StatefulWidget {
  const MakeUserScreen({Key? key}) : super(key: key);

  @override
  State<MakeUserScreen> createState() => _MakeUserScreenState();
}

class _MakeUserScreenState extends State<MakeUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Make Users Screen",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
