import 'package:flutter/material.dart';
import 'package:pokee/api/api.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/models/addusermodel.dart';
import 'package:pokee/screens/dashboard_screen/dashboard_screen.dart';

class UsernameScreen extends StatefulWidget {
  String Uid;
  String firstname;
  String lastname;
  String mobileno;
  UsernameScreen(this.Uid, this.mobileno, this.firstname, this.lastname,
      {Key? key})
      : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _nameController = TextEditingController();

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
                      "Enter your Username ?",
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
                      controller: _nameController,
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
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      AddUserModel data = await AddUser().AddUserData(
                          widget.Uid,
                          widget.firstname,
                          widget.lastname,
                          _nameController.text.trim(),
                          widget.mobileno);

                      if ((data.id).toString() == widget.Uid) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DashBoardScreen(widget.Uid),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Something went wrong!!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          backgroundColor: PrimaryColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.all(30),
                        ));
                      }
                    },
                    child: Container(
                      width: size.width - 100,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _nameController.text.isNotEmpty
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
        ],
      ),
    );
  }
}
