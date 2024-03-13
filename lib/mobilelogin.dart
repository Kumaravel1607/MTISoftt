import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';

import 'package:google/Constant/color.dart';
import 'package:google/Constant/toast.dart';

import 'package:google/otpscreen.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Mobile_login extends StatefulWidget {
  Mobile_login({Key? key}) : super(key: key);

  @override
  State<Mobile_login> createState() => _Mobile_loginState();
}

class _Mobile_loginState extends State<Mobile_login> {
  bool isloading = false;

  @override
  void initState() {
    // user();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();

  // final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // final phoneNumberController = TextEditingController();
  // TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 120),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/log-grow.png',
                height: 150,
                fit: BoxFit.cover,
              )),

              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  ' Student Login',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Mobile number',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                // onChanged: (value) {
                //   context
                //       .read<LoginBloc>()
                //       .add(EmailEvent(value));
                // },

                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter mobile number";
                  }

                  return null;
                },
                controller: phoneNumber,
                autocorrect: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Blue, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: box),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Blue, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 24, top: 14, bottom: 13),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your mobile number",
                    hintStyle: const TextStyle(
                        color: grey, fontFamily: 'Rubik', fontSize: 14),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Blue,
                    )),
              ),

              SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Blue,
                      minimumSize: Size.fromHeight(44),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          isloading = true;
                          print(isloading);
                          data();
                          // phoneSignIn(mobileNumber: '+91' + phoneNumber.text);
                          // sendotp(phoneNumberController.text);

                        }
                      });
                    },
                    child: isloading == true
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Don't have an account ?",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontFamily: 'IBMPlexSans',
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     Text(
              //       "Register",
              //       style: TextStyle(
              //         color: Blue,
              //         fontSize: 16,
              //         fontFamily: 'IBMPlexSans',
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Center(
              //   child: Text(
              //     "Are you a teacher ?",
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontFamily: 'IBMPlexSans',
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Center(
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => Staff_Login()));
              //     },
              //     child: Text(
              //       "Click here",
              //       style: TextStyle(
              //         color: Blue,
              //         fontSize: 16,
              //         fontFamily: 'IBMPlexSans',
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    )));
  }

  void data() async {
    var url = requestotp;
    var data = {
      // "name":name.text,
      ' mobile_no': phoneNumber.text
    };
    print(data);
    var body = json.encode(data);
    var urlparse = Uri.parse(url);

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
      // print(response_data['result']['user_id']);
      // print(response_data['result']['first_name']);

      // print(response_data['result']['email']);
      // final session = await SharedPreferences.getInstance();
      // await session.setString('email', response_data['result']['email']);
      // await session.setInt('student_id', response_data['result']['user_id']);
      // await session.setString(
      //     'user_name', response_data['result']['first_name']);
      // await session.setString('section', response_data['result']['section']);
      // // await prefs.setInt('id', response_data['user_id']);
      // var user_name = session.getString('user_name');
      setState(() {});
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => OtpScreen(
                    mobile: phoneNumber.text,
                  )),
          (Route<dynamic> route) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Navigation()));
      print('Success');
      toastInfo(mesg: response_data['message'].toString());
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(response_data['message'].toString()),
      //   backgroundColor: Blue.withOpacity(0.6),
      // ));
    } else {
      setState(() {
        isloading = false;
      });

      toastInfo(mesg: response_data['message'].toString());
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   behavior: SnackBarBehavior.floating,
      //   content: Text(response_data['message'].toString()),
      //   backgroundColor: Blue.withOpacity(0.6),
      // ));
    }
  }

  // var VerificationId = '';
  // var phone = '';
  // sendotp(phone) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       verificationCompleted: phone,
  //       verificationFailed: (e) {
  //         if (e.code == 'invalid-phone-number') {
  //           toastInfo(mesg: 'the provided phone number is invalid');
  //         } else {
  //           toastInfo(mesg: 'Something went wrong. Try again');
  //         }
  //       },
  //       codeSent: (verificationId, forceResendingToken) {
  //         verificationId = VerificationId.toString();
  //       },
  //       codeAutoRetrievalTimeout: (value) {});
  // }

  // String? verificationId;
  // Future<void> phoneSignIn({required String mobileNumber}) async {
  //   await _auth.verifyPhoneNumber(
  //       // phoneNumber: phoneNumber,
  //       // verificationCompleted: _onVerificationCompleted,
  //       // verificationFailed: _onVerificationFailed,
  //       // codeSent: _onCodeSent,
  //       // codeAutoRetrievalTimeout: _onCodeTimeout);

  //       phoneNumber: mobileNumber,
  //       verificationCompleted: (phoneAuthCredential) async {
  //         setState(() {
  //           isloading = false;
  //         });
  //       },
  //       verificationFailed: (e) {
  //         if (e.code == 'invalid-phone-number') {
  //           toastInfo(mesg: 'the provided phone number is invalid');
  //         } else {
  //           toastInfo(mesg: 'Something went wrong. Try again');
  //         }
  //       },
  //       codeSent: (verificationId, forceResendingToken) {
  //         verificationId = verificationId.toString();
  //       },
  //       codeAutoRetrievalTimeout: (value) {});
  // }

  // _onVerificationCompleted(PhoneAuthCredential authCredential) async {
  //   print("verification completed ${authCredential.smsCode}");
  //   User? user = FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     this.otpCode.text = authCredential.smsCode!;
  //   });
  //   if (authCredential.smsCode != null) {
  //     try {
  //       UserCredential credential =
  //           await user!.linkWithCredential(authCredential);
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'provider-already-linked') {
  //         await _auth.signInWithCredential(authCredential);
  //       }
  //     }
  //     setState(() {
  //       isloading = true;
  //     });
  //   }
  // }

  // _onVerificationFailed(FirebaseAuthException exception) {
  //   if (exception.code == 'invalid-phone-number') {
  //     toastInfo(mesg: "The phone number entered is invalid!");
  //   }
  // }

  // _onCodeSent(String verificationId, int? forceResendingToken) {
  //   this.verificationId = verificationId;
  //   print(forceResendingToken);
  //   print("code sent");
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => OtpScreen()));
  // }

  // _onCodeTimeout(String timeout) {
  //   return null;
  // }
}
