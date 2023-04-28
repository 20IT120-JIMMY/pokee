import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/screens/auth_screens/login_screen/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedCountryCode = '+91';
  List<String> _countryCodes = ['+91', '+23'];

  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      height: 45.0,
      margin: const EdgeInsets.all(3.0),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w500),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCountryCode = value;
              });
            },
          ),
        ),
      ),
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
                      "Enter your phone number",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    color: Colors.white,
                    child: TextFormField(
                      controller: _mobileController,
                      cursorColor: Colors.black,
                      cursorWidth: 1.5,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter phone number';
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17,
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusColor: Colors.black,
                        fillColor: Colors.white,
                        prefixIcon: countryDropDown,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "We will send you a verification code",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_mobileController.text.toString().length == 10) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              mobile: _mobileController.text.trim(),
                              countrycode: _selectedCountryCode.toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: size.width - 100,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _mobileController.length == 10
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
