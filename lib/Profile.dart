import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profile_page();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: violet,
        automaticallyImplyLeading: false,
        title: Text(
          "My Profile",
          style: TextStyle(
              color: white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              //height: 180,
              width: double.infinity,
              color: violet.withOpacity(0.84),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        //backgroundColor: Colors.greenAccent,
                        radius: 70,
                        backgroundImage: AssetImage(
                          'assets/images/user.png',
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _firstname,
                              // "Pandiyan_Gandhi",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mobile Number",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _mobile,
                              // "9976850646",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _email,
                              // "pandi@gmail.com",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date of Birth",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _dob,
                              // "29-12-1998",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Course",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _section,
                              // "DEG",
                              // _username,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  String _firstname = "";
  String _lastname = '';
  String _mobile = '';
  String _email = '';
  String _dob = '';
  String _section = '';
  profile_page() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');
    var user_name = session.getString('user_name');
    var section = session.getString('section');
    // _username = user_name.toString();
    // _section = section.toString();

    var url = profile;
    var data = {'student_id': student_id.toString()};

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
        _firstname = (response_data['result']['first_name'].toString());
        _lastname = (response_data['result']['last_name'].toString());
        _mobile = (response_data['result']['mobile_no'].toString());
        _dob = (response_data['result']['dob'].toString());
        _email = (response_data['result']['email'].toString());
        _section = (response_data['result']['section'].toString());
      });
      print(_firstname);
      print(_lastname);
      print(_mobile);
      print(_dob);

      // print('Sucessfull');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Blue.withOpacity(0.6),
      ));
    }
  }
}
