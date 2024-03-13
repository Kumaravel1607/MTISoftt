import 'dart:convert';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:google/History.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Leave_Details extends StatefulWidget {
  final String id;
  final int screen;
  Leave_Details({Key? key, required this.id, required this.screen})
      : super(key: key);

  @override
  State<Leave_Details> createState() => _Leave_DetailsState();
}

class _Leave_DetailsState extends State<Leave_Details> {
  String _reason = '';
  String _type = '';
  String _fromdate = '';
  String _fromtime = '';
  String _todate = '';
  String _totime = '';
  String _principalapproval = '';
  String _parentapproval = '';
  String _statusopen = '';
  String _statustext = '';
  String _name = '';
  String _deg = '';
  int _statusnum = 0;

  @override
  void initState() {
    super.initState();
    leavedetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: violet,
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        leading: GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => History_Screen()),
                (Route<dynamic> route) => false);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back,
              color: white,
            ),
          ),
        ),
        title: Text(
          "Leave Details",
          style: TextStyle(
              fontFamily: 'Poppins',
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "REASON",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _reason,
                              // "Permission",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "REQUEST TYPE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _type,
                              // "ATM",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FROM DATE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _fromdate,
                              // "22 JUN 2023",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FROM TIME",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _fromtime,
                              //  "09:00:AM",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TO DATE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _todate,
                              // "22 JUN 2023",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TO TIME",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _totime,
                              //"05:00:PM",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "STATUS",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _statustext,
                              //"05:00:PM",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
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
      ),
    );
  }

  void leavedetails() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var id = session.getInt('id');
    var url = Detail;
    var data = {"id": widget.id};
    print(data);
    print(url);
    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      setState(() {});
      _reason = (response_data['results']['request_type'].toString());
      _type = (response_data['results']['reason_type'].toString());
      _fromdate = (response_data['results']['from_date'].toString());
      _fromtime = (response_data['results']['from_time'].toString());
      _todate = (response_data['results']['to_date'].toString());
      _totime = (response_data['results']['to_time'].toString());
      _parentapproval = (response_data['results']['parents_status'].toString());
      _principalapproval =
          (response_data['results']['principal_status'].toString());
      _statusopen = (response_data['results']['status_open'].toString());
      _statustext = (response_data['results']['status_text'].toString());
      _name = (response_data['results']['first_name'].toString());
      _deg = (response_data['results']['section'].toString());
      _statusnum =
          int.parse(response_data['results']['current_status'].toString());

      print('Success');
    } else {
      // toastInfo(mesg: response_data['message'].toString());
    }
  }
}
