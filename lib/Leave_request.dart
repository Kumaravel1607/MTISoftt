import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Navigation.dart';
import 'package:google/notification_services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveRequest extends StatefulWidget {
  LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  bool isloading = false;
  var isrequest = false;

  // var a = DateTime.now();
  // var b = DateTime.now().add(Duration(days: 1));
  NotificationServices notificationServices = NotificationServices();
  int access = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastrequest();
    fromdate.text = '';
    fromtime.text = '';
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController fromtime = TextEditingController();
  TextEditingController fromdate = TextEditingController();
  TextEditingController totime = TextEditingController();
  TextEditingController todate = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fromdate.text = '';
  //   fromtime.text = '';
  //   // timeofDay = TimeOfDay.now();
  // }

  String dropdownvalue = 'Permission';
  String? requesttype;
  final List Items = [
    'Permission',
    'Leave',
  ];
  String? reasontype;
  String value2 = 'ATM';
  final List Items2 = ['ATM', 'Outing', 'Hospital', 'Home'];
  //final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  lastrequest() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');

    Map data = {
      'student_id': student_id.toString(),
    };

    var url = last_request;

    // var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      print(response_data['status']);
      setState(() {
        access = (response_data['status']);
      });
      // Text("Already requested");
    } else {
      Fluttertoast.showToast(
          msg: response_data['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 16.0);
    }
  }

  request() async {
    print("----------5");
    SharedPreferences session = await SharedPreferences.getInstance();

    var Email = session.getString('email');
    var student_id = session.getInt('student_id');

    print("----------6");
    Map data = {
      'student_id': student_id.toString(),
      'request_type': requesttype.toString(),
      'reason_type': reasontype.toString(),
      'from_date': fromdate.text,
      'from_time': fromtime.text,
      'to_date': todate.text,
      'to_time': totime.text,
    };
    print("----------7");
    print(data);

    var url = request_leave;

    // var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response_data['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Navigation();
          },
        ),
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Blue.withOpacity(0.6),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 1,
          backgroundColor: violet,
          titleSpacing: 15,
          title: Text(
            "Leave Request",
            style: TextStyle(
                color: white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            request();
            lastrequest();
          },
          child: access == 1
              ? Center(
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Already Requested",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      )))
              : SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Form(
                    key: formkey,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 35,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request Type',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 45,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500),
                                  value: null,
                                  // value: _gender,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      requesttype = newValue as String;
                                      requesttype =
                                          (Items.indexOf(newValue) + 1)
                                              .toString();
                                      print(requesttype);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please enter Request type";
                                    }

                                    return null;
                                  },

                                  // validator: (newValue) =>
                                  //     newValue == null ? 'Requesttype' : null,
                                  items: Items.map((List) {
                                    return DropdownMenuItem(
                                        child: Text(List), value: List);
                                  }).toList(),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 14, right: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Blue),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'Select Request Type',
                                    // hintText: 'Date-Month-Year',

                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal),
                                    focusedErrorBorder: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: red, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: red, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // border: OutlineInputBorder(
                                    //   borderRadius: const BorderRadius.all(
                                    //     const Radius.circular(10),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Request Option',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 45,
                              child: DropdownButtonFormField(
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500),
                                value: null,
                                validator: (newValue) => newValue == null
                                    ? 'Please enter Reason'
                                    : null,
                                isExpanded: true,
                                onChanged: (Value) {
                                  setState(() {
                                    reasontype = Value as String;
                                    reasontype =
                                        (Items2.indexOf(Value) + 1).toString();
                                    //var reasontype = Items2.indexOf(Value);
                                    print(reasontype);
                                  });
                                },
                                items: Items2.map((List) {
                                  return DropdownMenuItem(
                                      child: Text(List), value: List);
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, top: 14, right: 20),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Select Reason',
                                  // hintText: 'Date-Month-Year',
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  focusedErrorBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: red,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: red, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // border: OutlineInputBorder(

                                  //   borderRadius: const BorderRadius.all(
                                  //     const Radius.circular(10),
                                  // ),
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'FromDate',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter fromdate";
                                }
                                return null;
                              },
                              onSaved: (date) {
                                date = date!;
                              },
                              onTap: () async {
                                DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now().add(Duration(days: 0)),
                                  firstDate:
                                      DateTime.now().add(Duration(days: 0)),
                                  lastDate: DateTime(2100),
                                );

                                if (datePicked != null) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(datePicked);

                                  //dd-MM--yyyy
                                  setState(() {
                                    fromdate.text = formattedDate.toString();
                                  });
                                }
                              },
                              controller: fromdate,
                              decoration: InputDecoration(
                                  // fillColor: light,
                                  // filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintText: 'FormDate',
                                  // hintText: 'Date-Month-Year',
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime? datePicked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now()
                                              .add(Duration(days: 0)),
                                          firstDate: DateTime.now()
                                              .add(Duration(days: 0)),
                                          lastDate: DateTime(2100),
                                        );

                                        if (datePicked != null) {
                                          String formattedDate =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(datePicked);
                                          //dd-MM--yyyy
                                          setState(() {
                                            fromdate.text =
                                                formattedDate.toString();
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.calendar_today,
                                          color: greylite))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'FromTime',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter from time";
                                }
                                return null;
                              },
                              onSaved: (time) {
                                time = time!;
                              },
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 09, minute: 00),
                                        initialEntryMode:
                                            TimePickerEntryMode.input);
                                if (pickedTime != null) {
                                  setState(() {
                                    MaterialLocalizations localizations =
                                        MaterialLocalizations.of(context);
                                    String formattedTime = localizations
                                        .formatTimeOfDay(pickedTime,
                                            alwaysUse24HourFormat: true);

                                    fromtime.text = formattedTime.toString();
                                    // String formattedtime = DateFormat('hh:mm a')
                                    //     .format(pickedTime);
                                    // timeController.text =
                                    //     formattedtime.toString();
                                  });
                                }
                              },
                              controller: fromtime,
                              decoration: InputDecoration(
                                  // fillColor: light,
                                  // filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintText: 'FromTime',
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),

                                  // suffixIcon: Icon(Icons.access_time, color: greylite)
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 09, minute: 00),
                                                initialEntryMode:
                                                    TimePickerEntryMode.input);
                                        if (pickedTime != null) {
                                          setState(() {
                                            MaterialLocalizations
                                                localizations =
                                                MaterialLocalizations.of(
                                                    context);
                                            String formattedTime = localizations
                                                .formatTimeOfDay(pickedTime,
                                                    alwaysUse24HourFormat:
                                                        true);

                                            fromtime.text =
                                                formattedTime.toString();
                                            // String formattedtime = DateFormat('hh:mm a')
                                            //     .format(pickedTime);
                                            // timeController.text =
                                            //     formattedtime.toString();
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.access_time,
                                        color: greylite,
                                      ))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'ToDate',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter todate";
                                }
                                return null;
                              },
                              onSaved: (date) {
                                date = date!;
                              },
                              onTap: () async {
                                DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now().add(Duration(days: 0)),
                                  firstDate:
                                      DateTime.now().add(Duration(days: 0)),
                                  lastDate: DateTime(2100),
                                );

                                if (datePicked != null) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(datePicked);
                                  //dd-MM--yyyy
                                  setState(() {
                                    todate.text = formattedDate.toString();
                                  });
                                }
                              },
                              controller: todate,
                              decoration: InputDecoration(
                                  // fillColor: light,
                                  // filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintText: 'ToDate',
                                  // hintText: 'Date-Month-Year',
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime? datePicked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now()
                                              .add(Duration(days: 0)),
                                          firstDate: DateTime.now()
                                              .add(Duration(days: 0)),
                                          lastDate: DateTime(2100),
                                        );

                                        if (datePicked != null) {
                                          String formattedDate =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(datePicked);
                                          //dd-MM--yyyy
                                          setState(() {
                                            todate.text =
                                                formattedDate.toString();
                                          });
                                        }
                                        // print(
                                        //     'Date Selected: ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                      },
                                      icon: Icon(Icons.calendar_today,
                                          color: greylite))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'ToTime',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter totime";
                                }
                                return null;
                              },
                              onSaved: (time) {
                                time = time!;
                              },
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 18, minute: 00),
                                        initialEntryMode:
                                            TimePickerEntryMode.input);
                                if (pickedTime != null) {
                                  setState(() {
                                    MaterialLocalizations localizations =
                                        MaterialLocalizations.of(context);
                                    String formattedTime = localizations
                                        .formatTimeOfDay(pickedTime,
                                            alwaysUse24HourFormat: true);

                                    totime.text = formattedTime.toString();
                                    // String formattedtime = DateFormat('hh:mm a')
                                    //     .format(pickedTime);
                                    // timeController.text =
                                    //     formattedtime.toString();
                                  });
                                }
                              },
                              controller: totime,
                              decoration: InputDecoration(
                                  // fillColor: light,
                                  // filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintText: 'ToTime',
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),

                                  // suffixIcon: Icon(Icons.access_time, color: greylite)
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 18, minute: 00),
                                                initialEntryMode:
                                                    TimePickerEntryMode.input);
                                        if (pickedTime != null) {
                                          setState(() {
                                            MaterialLocalizations
                                                localizations =
                                                MaterialLocalizations.of(
                                                    context);
                                            String formattedTime = localizations
                                                .formatTimeOfDay(pickedTime,
                                                    alwaysUse24HourFormat:
                                                        true);

                                            totime.text =
                                                formattedTime.toString();
                                            // String formattedtime = DateFormat('hh:mm a')
                                            //     .format(pickedTime);
                                            // timeController.text =
                                            //     formattedtime.toString();
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.access_time,
                                        color: greylite,
                                      ))),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      // side: const BorderSide(
                                      //   width: 2,
                                      //   color: Blue,
                                      // ),
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: violet,
                                  minimumSize: const Size.fromHeight(44),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (formkey.currentState!.validate()) {
                                      isloading = true;
                                      print(isloading);
                                      request();
                                      notificationServices
                                          .getDeviceToken()
                                          .then((value) async {});
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
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'IBMPlexSans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
