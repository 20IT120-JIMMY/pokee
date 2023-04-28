import 'package:flutter/material.dart';
import 'package:pokee/api/api.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/models/getusermodel.dart';

class ProfileScreen extends StatefulWidget {
  String Uid;
  ProfileScreen(this.Uid, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<GetUserModel>(
            future: GetUser().UserData(widget.Uid),
            builder: (context, snapshots) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 5.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                      child: Text(
                        "pokee",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 30,
                          letterSpacing: 1,
                          color: PrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110),
                    padding: EdgeInsets.all(2),
                    child: Image.asset(
                      'assets/images/ruhii.jpg',
                      width: double.infinity,
                      height: 500,
                    ),
                  ),
                  Positioned(
                      top: 120,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: PrimaryColor,
                            content: Text(
                              "Menu Option!!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ));
                        },
                        child: Icon(
                          Icons.more_vert_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      )),
                  Positioned(
                      top: 520,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshots.data?.displayName != null
                                ? (snapshots.data?.displayName).toString()
                                : "User",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 28,
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            snapshots.data?.userName != null
                                ? (snapshots.data?.userName).toString()
                                : "UserName",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 25,
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )),
                ],
              );
            }));
  }
}
