import 'package:flutter/material.dart';
import 'package:google/Constant/color.dart';
import 'package:google/LeaveDetails.dart';
import 'package:google/Services/services.dart';
import 'package:google/models/leavehistory_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class History_Screen extends StatefulWidget {
  History_Screen({Key? key}) : super(key: key);

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> {
  late List<LeaveHistory> users = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    history();
  }

  history() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var student_id = session.getInt('student_id');
    var email = session.getString('email');

    print("--------");
    print(email);
    print(student_id);

    Services.leavehistory().then((results) {
      setState(() {
        isloading = false;
        users = results;

        //print(users[0].gameTittle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: violet,
          automaticallyImplyLeading: false,
          title: Text(
            "Leave History",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            history();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: isloading == true
                      ? CircularProgressIndicator()
                      : users.length == 0
                          ? Center(child: Text("No List Found"))
                          : Column(
                              children: [
                                ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final user = users[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    user.requestType,
                                                    // "PERMISSION",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: lite,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        user.fromDate
                                                                .toString() +
                                                            "  - " +
                                                            user.toDate
                                                                .toString(),

                                                        // "22 JUN 2023 - 22 JUN 2023",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      SizedBox(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  backgroundColor: (user
                                                                              .status ==
                                                                          '3')
                                                                      ? Colors
                                                                          .red
                                                                      : (user.status) ==
                                                                              '5'
                                                                          ? Colors
                                                                              .red
                                                                          : (user.status) == '7'
                                                                              ? Colors.green.shade500
                                                                              : Colors.orange.shade500),
                                                          onPressed: () {},
                                                          child: Text(
                                                            user.statusText,
                                                            // "APPROVED",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        user.reasonType,
                                                        //"ATM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  Leave_Details(
                                                                      id: user
                                                                          .id
                                                                          .toString(),
                                                                      screen:
                                                                          2)));
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/next.png',
                                                          height: 20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                ),
              ),
            ),
          ),
        ));
  }
}
