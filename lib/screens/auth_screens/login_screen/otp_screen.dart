import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pokee/api/api.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/models/getusermodel.dart';
import 'package:pokee/screens/auth_screens/account_screen.dart';
import 'package:pokee/screens/auth_screens/login_screen/firstname_screen.dart';
import 'package:pokee/screens/dashboard_screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  String countrycode;
  String mobile;
  OtpScreen({required this.mobile, required this.countrycode});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String generatedOtp = "";
  String contact = "";
  String globalVerificationId = "";
  String? Input_pin = "";
  int secondsRemaining = 60;
  bool enableResend = false;
  bool wrong_otp = false;

  verifyOtp(String otpText) async {
    _signInWithPhoneNumber(otpText);
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  bool isLoading = false;
  late String _verificationId;
  bool autovalidate = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyPhoneNumber() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          authException.message.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: PrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(30),
      ));
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please check your phone for the verification code",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: PrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(30),
      ));
      _verificationId = verificationId;
    } as PhoneCodeSent;

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {};

    if (kIsWeb) {
      await _auth
          .signInWithPhoneNumber(
        widget.countrycode + widget.mobile,
      )
          .then((value) {
        _verificationId = value.verificationId;
      }).catchError((onError) {});
    } else {
      await _auth
          .verifyPhoneNumber(
              phoneNumber: widget.countrycode + widget.mobile,
              timeout: Duration(seconds: 60),
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {})
          .catchError((onError) {});
    }

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  void _signInWithPhoneNumber(String otp) async {
    final SharedPreferences prefs = await _prefs;

    _showProgressDialog(true);

    if (await Utility.checkInternet()) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        final User? user = (await _auth.signInWithCredential(credential)).user;
        final User? currentUser = _auth.currentUser;
        assert(user?.uid == currentUser?.uid);

        _showProgressDialog(false);

        GetUserModel data =
            await GetUser().UserData((currentUser?.uid).toString());

        if (prefs.getBool("SignIN") as bool == true) {
          if ((data.id == (currentUser?.uid).toString())) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      DashBoardScreen((currentUser?.uid).toString())),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "You need to create account first !!!",
                style:
                    TextStyle(color: PrimaryColor, fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(30),
            ));
            (Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AccountScreen(),
            )));
          }
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FirstName((currentUser?.uid).toString(),
                (widget.countrycode + widget.mobile)),
          ));
        }
      } catch (e) {
        _showProgressDialog(false);
        wrong_otp = true;
      }
    } else {
      _showProgressDialog(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "No internet connection !!!",
          style: TextStyle(color: PrimaryColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: PrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(30),
      ));
    }
  }

  _showProgressDialog(bool isloadingstate) {
    if (mounted)
      setState(() {
        isLoading = isloadingstate;
      });
  }

  @override
  Widget build(BuildContext context) {
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: PrimaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: const BoxDecoration(),
    );
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
              width: double.infinity,
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
                    margin: EdgeInsets.symmetric(vertical: 60),
                    child: Text(
                      "Enter your verification code",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Pinput(
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      length: 6,
                      showCursor: true,
                      // pinAnimationType: PinAnimationType.slide,
                      preFilledWidget: preFilledWidget,
                      defaultPinTheme: defaultPinTheme,
                      cursor: cursor,
                      onCompleted: (pin) => {
                        setState(() {
                          Input_pin = pin;
                        }),
                        verifyOtp(Input_pin.toString())
                      },
                    ),
                  ),
                  wrong_otp == true
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            "INCORRECT OTP",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              letterSpacing: 1,
                              color: PrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        enableResend == true
                            ? InkWell(
                                onTap: () {
                                  _verifyPhoneNumber();
                                },
                                child: Row(
                                  children: [
                                    Text("Didn't get the code ?  ",
                                        style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                      ' Resend',
                                      style: TextStyle(
                                          color: PrimaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ))
                            : Text("Didn't get the code? Resend",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  secondsRemaining.toString() != "0"
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            '$secondsRemaining second',
                            style: TextStyle(color: PrimaryColor, fontSize: 15),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Utility {
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
