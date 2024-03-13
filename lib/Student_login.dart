import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Constant/toast.dart';
import 'package:google/Navigation.dart';
import 'package:google/mobilelogin.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Student_login extends StatefulWidget {
  Student_login({Key? key}) : super(key: key);

  @override
  State<Student_login> createState() => _Student_loginState();
}

class _Student_loginState extends State<Student_login> {
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

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _passVisibility = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: formkey,
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
                height: 30,
              ),
              Text(
                'Username',
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

                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter username";
                  }

                  return null;
                },
                controller: email,
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
                    hintText: "Enter your username",
                    hintStyle: const TextStyle(
                        color: grey, fontFamily: 'Rubik', fontSize: 14),
                    prefixIcon: Icon(
                      Icons.mail_rounded,
                      color: Blue,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                // onChanged: (value) {
                //   context
                //       .read<LoginBloc>()
                //       .add(PasswordEvent(value));
                // },

                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }

                  return null;
                },
                controller: pass,
                autocorrect: true,
                obscureText: _passVisibility,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: red, width: 2)),
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
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                        fontFamily: 'Rubik', color: grey, fontSize: 14),
                    suffixIcon: IconButton(
                      color: grey,
                      icon: _passVisibility
                          ? Icon(
                              Icons.visibility_off,
                              color: LiteBlue,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Blue,
                            ),
                      onPressed: () {
                        _passVisibility = !_passVisibility;
                        setState(() {});
                      },
                    ),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
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
                      minimumSize: const Size.fromHeight(44),
                    ),
                    onPressed: () {
                      setState(() {
                        if (formkey.currentState!.validate()) {
                          isloading = true;
                          print(isloading);
                          data();
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
                            'Sign in',
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
                height: 10,
              ),
            ],
          ),
        ),
      ),
    )));
  }

  void data() async {
    String? deviceId = await _getId();
    String? token = await FirebaseMessaging.instance.getToken();
    print('Deviceid :' '$deviceId');
    print('token :' '$token');
    var url = Login;
    var data = {
      // "name":name.text,
      "email": email.text,
      "password": pass.text,

      "app_key": token,
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

      print('Success');
      toastInfo(mesg: response_data['message'].toString());
    } else {
      setState(() {
        isloading = false;
      });

      toastInfo(mesg: response_data['message'].toString());
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
