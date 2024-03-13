import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Student_login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashBoard_Screen extends StatefulWidget {
  DashBoard_Screen({Key? key}) : super(key: key);

  @override
  State<DashBoard_Screen> createState() => _DashBoard_ScreenState();
}

class _DashBoard_ScreenState extends State<DashBoard_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Blue,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Logout",
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Blue,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      onPressed: () async {
        // Obtain shared preferences.
        final session = await SharedPreferences.getInstance();
        // Remove data for the 'counter' key.
        await session.remove('email');
        await session.remove('student_id');

        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Student_login();
            },
          ),
          (_) => false,
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Logout",
        style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        "Do you Really want to logout?",
        style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: violet,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                    ))),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            home();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(
                children: [
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
                              radius: 50,
                              backgroundImage: AssetImage(
                                'assets/images/user.png',
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _username,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _section,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _pending != ''
                            ? Card(
                                elevation: 5,
                                child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(Icons.notifications),
                                    ),
                                    title: Text(
                                      "Pending Request ",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          "Status : ",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              // color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _pending,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              // color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOTAL REQUEST",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    _total,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            elevation: 5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "APPORVED LEAVE",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    _approved,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            elevation: 5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "REJECTED LEAVE",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    _reject,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            elevation: 5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String _total = "";
  String _approved = '';
  String _reject = '';
  String _pending = '';
  String _username = '';
  String _section = '';
  // String _statustext = '';
  home() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');
    var user_name = session.getString('user_name');
    var section = session.getString('section');
    _username = user_name.toString();
    _section = section.toString();

    var url = Dashboard;
    var data = {'student_id': student_id.toString()};

    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      setState(() {
        _total = (response_data['result']['all_count'].toString());
        _approved = (response_data['result']['active_count'].toString());
        _reject = (response_data['result']['reject_count'].toString());
        _pending = (response_data['result']['pending_count'].toString());
      });
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Blue.withOpacity(0.6),
      ));
    }
  }
}
