import 'package:flutter/material.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/screens/auth_screens/login_screen/username_screen.dart';

class LastNameScreen extends StatefulWidget {
  String Uid;
  String firstname;
  String mobileno;
  LastNameScreen(this.Uid, this.mobileno, this.firstname, {Key? key})
      : super(key: key);

  @override
  State<LastNameScreen> createState() => _LastNameScreenState();
}

class _LastNameScreenState extends State<LastNameScreen> {
  final TextEditingController _lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: PrimaryColor,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 70, horizontal: 10),
              child: Text(
                "pokee",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 35,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 50),
                    child: Text(
                      "Enter your Last Name ?",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    child: TextField(
                      cursorColor: PrimaryColor,
                      keyboardType: TextInputType.text,
                      controller: _lastnameController,
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17,
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: PrimaryColor)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UsernameScreen(
                            widget.Uid,
                            widget.mobileno,
                            widget.firstname,
                            _lastnameController.text.trim()),
                      ));
                    },
                    child: Container(
                      width: size.width - 100,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _lastnameController.text.isNotEmpty
                              ? PrimaryColor
                              : Colors.grey.withOpacity(0.6)),
                      child: Center(
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 17,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 160,
              right: 5,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UsernameScreen(
                        widget.Uid,
                        widget.mobileno,
                        widget.firstname,
                        _lastnameController.text.trim()),
                  ));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
