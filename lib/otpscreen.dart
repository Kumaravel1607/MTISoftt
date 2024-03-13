import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google/Constant/toast.dart';
import 'package:google/Navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isResendAgain = false;
bool focus = false;

class OtpScreen extends StatefulWidget {
  final String mobile;

  OtpScreen({
    Key? key,
    required this.mobile,
    // required this.checkotp,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

final TextEditingController otp = new TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController email = new TextEditingController();
bool isloading = false;

class _OtpScreenState extends State<OtpScreen> {
  int start = 30;
  // late Timer timer;
  // late String _code;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //timer.cancel();
  }

  void check_otp() async {
    //String? deviceId = await _getId();
    String? token = await FirebaseMessaging.instance.getToken();
    // print('Deviceid :' '$deviceId');
    print('token :' '$token');
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var Email = _pref.getString("email");
    Map data = {
      'mobile_no': widget.mobile,
      'otp': otp.text,
      "app_key": token,
    };
    var url = CheckOtp;
    var urlparse = Uri.parse(url);

    print(data);
    print(urlparse);
    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      setState(() {
        isloading = false;
      });
      print(response_data['result']);
      print(response_data['result']['user_id']);
      print(response_data['result']['first_name']);

      print(response_data['result']['email']);
      final session = await SharedPreferences.getInstance();
      await session.setString('email', response_data['result']['email']);
      await session.setInt('student_id', response_data['result']['user_id']);
      await session.setString(
          'user_name', response_data['result']['first_name']);
      await session.setString('section', response_data['result']['section']);
      // await prefs.setInt('id', response_data['user_id']);
      var user_name = session.getString('user_name');
      setState(() {});
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Navigation()),
          (Route<dynamic> route) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Navigation()));
      print('Success');
      toastInfo(mesg: response_data['message'].toString());
    } else {
      setState(() {
        isloading = false;
      });

      toastInfo(mesg: response_data['message'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
            backgroundColor: Blue,
            elevation: 3,
            shadowColor: grey,
            titleSpacing: -4,
            title: const Text(
              "Enter OTP",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'IBMPlexSans',
                  color: white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left),
            )
            // automaticallyImplyLeading: false,
            ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Text(
                    "An OTP has been sent to your registered mobile phone number ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.normal,
                        color: black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: PinCodeTextField(
                    appContext: context,
                    // pastedTextStyle: TextStyle(
                    //   color: Colors.green.shade600,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    length: 6,
                    obscureText: false,
                    // animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 45,
                        fieldWidth: 45,
                        inactiveFillColor: Colors.white,
                        inactiveColor: grey,
                        selectedColor: Blue,
                        selectedFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        activeColor: red),

                    controller: otp,
                    keyboardType: TextInputType.number,

                    onCompleted: (v) {
                      //do something or move to next screen when code complete
                    },
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        // print('$value');
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Blue,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    onPressed: () {
                      check_otp();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ResetScreen()));
                    },
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // void startTimer() {
  //   setState(() {
  //     _isResendAgain = true;
  //   });

  //   const oneSec = Duration(seconds: 1);
  //   timer = new Timer.periodic(oneSec, (timer) {
  //     setState(() {
  //       if (start == 0) {
  //         start = 30;
  //         _isResendAgain = false;
  //         timer.cancel();
  //       } else {
  //         start--;
  //       }
  //     });
  //   });
  // }
}
