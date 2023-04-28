import 'package:flutter/material.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/screens/auth_screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 250),
              child: Text(
                "pokee",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 40,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              final SharedPreferences prefs = await _prefs;
                              prefs.setBool("SignIN", false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Container(
                              width: size.width - 100,
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "CREATE ACCOUNT",
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 17,
                                    color: Colors.black87,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              final SharedPreferences prefs = await _prefs;
                              prefs.setBool("SignIN", true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Container(
                              width: size.width - 100,
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 17,
                                    color: Colors.black87,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 8),
                    child: Text(
                      "By continuing, you agree to Pokee's Terms & conditions and confirm you have read Pokee's Privacy Policy.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
