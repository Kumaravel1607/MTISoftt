import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google/Api/api.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Constant/toast.dart';
import 'package:google/Navigation.dart';
import 'package:google/Student_login.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Password extends StatefulWidget {
  Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
  bool _passVisibility1 = true;
  bool _passVisibility2 = true;
  TextEditingController old = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: violet,
          title: Text(
            'Change Password',
            style: TextStyle(
                color: white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Old Password',
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
                        return "Please enter Old password";
                      }

                      return null;
                    },
                    controller: old,
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
                          const EdgeInsets.only(left: 14, top: 14, bottom: 13),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your Old password',
                      hintStyle: const TextStyle(color: grey, fontSize: 14),
                      suffixIcon: IconButton(
                        color: grey,
                        icon: _passVisibility
                            ? Icon(
                                Icons.visibility,
                                color: Blue,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: LiteBlue,
                              ),
                        onPressed: () {
                          _passVisibility = !_passVisibility;
                          setState(() {});
                        },
                      ),
                      // prefixIcon: Icon(
                      //   Icons.lock_rounded,
                      //   color: Blue,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'New Password',
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
                        return "Please enter new password";
                      }

                      return null;
                    },
                    controller: newpass,
                    autocorrect: true,
                    obscureText: _passVisibility1,
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
                          const EdgeInsets.only(left: 14, top: 14, bottom: 13),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your new password',
                      hintStyle: const TextStyle(
                          fontFamily: 'Rubik', color: grey, fontSize: 14),
                      suffixIcon: IconButton(
                        color: grey,
                        icon: _passVisibility1
                            ? Icon(
                                Icons.visibility_off,
                                color: LiteBlue,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Blue,
                              ),
                        onPressed: () {
                          _passVisibility1 = !_passVisibility1;
                          setState(() {});
                        },
                      ),
                      // prefixIcon: Icon(
                      //   Icons.lock_rounded,
                      //   color: Blue,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Confirm Password',
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
                        return "Please enter confirm password";
                      }

                      return null;
                    },
                    controller: confirm,
                    autocorrect: true,
                    obscureText: _passVisibility2,
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
                          const EdgeInsets.only(left: 14, top: 14, bottom: 13),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your confirm password',
                      hintStyle: const TextStyle(
                          fontFamily: 'Rubik', color: grey, fontSize: 14),
                      suffixIcon: IconButton(
                        color: grey,
                        icon: _passVisibility2
                            ? Icon(
                                Icons.visibility_off,
                                color: LiteBlue,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Blue,
                              ),
                        onPressed: () {
                          _passVisibility2 = !_passVisibility2;
                          setState(() {});
                        },
                      ),
                      // prefixIcon: Icon(
                      //   Icons.lock_rounded,
                      //   color: Blue,
                      // ),
                    ),
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
                              // data();
                              newpassword();
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

  void newpassword() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');

    var url = Change_password;
    var data = {
      "student_id": student_id.toString(),
      "old_password": old.text,
      "new_password": newpass.text,
      "confirm_password": confirm.text
    };
    print(data);

    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    Response response = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Navigation();
          },
        ),
        (_) => false,
      );
      toastInfo(mesg: response_data['message'].toString());
    } else {
      toastInfo(mesg: response_data['message'].toString());
    }
  }
}







//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       child: Align(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Are you sure you want to logout?',
//               style: TextStyle(
//                   fontFamily: 'NunitoSans',
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: black),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               height: 50,
//               width: 300,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     backgroundColor: violet,
//                     minimumSize: const Size.fromHeight(44),
//                   ),
//                   onPressed: () async {
//                     // Obtain shared preferences.
//                     final session = await SharedPreferences.getInstance();
//                     // Remove data for the 'counter' key.
//                     await session.remove('email');
//                     await session.remove('student_id');

//                     Navigator.of(context, rootNavigator: true)
//                         .pushAndRemoveUntil(
//                       MaterialPageRoute(
//                         builder: (BuildContext context) {
//                           return Student_login();
//                         },
//                       ),
//                       (_) => false,
//                     );
//                     //   Navigator.of(context).pushAndRemoveUntil(
//                     //       MaterialPageRoute(
//                     //           builder: (BuildContext context) => Student_login()),
//                     //       (Route<dynamic> route) => false);
//                     //   // Navigator.of(context).push(MaterialPageRoute(
//                     //   //     builder: (context) => Student_login()));
//                   },
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'LOGOUT',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
// // class LogoutScreen extends StatefulWidget {
// //   LogoutScreen({Key? key}) : super(key: key);

// //   @override
// //   State<LogoutScreen> createState() => _LogoutScreenState();
// // }

// // class _LogoutScreenState extends State<LogoutScreen> {
// //   var focusNode = FocusNode();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: GestureDetector(
// //         onTap: () {
// //           showModalBottomSheet(
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.only(
// //                       topLeft: Radius.circular(20),
// //                       topRight: Radius.circular(20))),
// //               context: context,
// //               isScrollControlled: true,
// //               builder: (BuildContext context) {
// //                 return Padding(
// //                   padding: EdgeInsets.only(
// //                       bottom: MediaQuery.of(context).viewInsets.bottom),
// //                   child: Container(
// //                     height: 180,
// //                     child: Padding(
// //                       padding: const EdgeInsets.only(
// //                         left: 16,
// //                       ),
// //                       child: Column(
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(top: 16),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   'Log out',
// //                                   style: TextStyle(
// //                                     color: black,
// //                                     fontFamily: 'IBMPlexSans',
// //                                     fontWeight: FontWeight.w500,
// //                                     fontSize: 16,
// //                                   ),
// //                                 ),
// //                                 IconButton(
// //                                     onPressed: () {
// //                                       Navigator.pop(context);
// //                                     },
// //                                     icon: Icon(Icons.close))
// //                               ],
// //                             ),
// //                           ),
// //                           SizedBox(
// //                             height: 5,
// //                           ),
// //                           Align(
// //                             alignment: Alignment.topLeft,
// //                             child: Text(
// //                               'Are you sure you want to logout?',
// //                               style: TextStyle(
// //                                   fontFamily: 'NunitoSans',
// //                                   fontSize: 14,
// //                                   fontWeight: FontWeight.w400,
// //                                   color: tab),
// //                             ),
// //                           ),
// //                           SizedBox(
// //                             height: 25,
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.only(right: 16),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 SizedBox(
// //                                   width: 160,
// //                                   child: ElevatedButton(
// //                                     style: ElevatedButton.styleFrom(
// //                                       shape: RoundedRectangleBorder(
// //                                           side: const BorderSide(
// //                                             width: 2,
// //                                             color: red,
// //                                           ),
// //                                           borderRadius:
// //                                               BorderRadius.circular(22)),
// //                                       backgroundColor: white,
// //                                       minimumSize: const Size.fromHeight(44),
// //                                     ),
// //                                     onPressed: () {},
// //                                     child: const Text(
// //                                       'Yes Logout',
// //                                       style: TextStyle(
// //                                         color: red,
// //                                         fontSize: 16,
// //                                         fontFamily: 'IBMPlexSans',
// //                                         fontWeight: FontWeight.w500,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 160,
// //                                   child: ElevatedButton(
// //                                     style: ElevatedButton.styleFrom(
// //                                       shape: RoundedRectangleBorder(
// //                                           borderRadius:
// //                                               BorderRadius.circular(22)),
// //                                       backgroundColor: red,
// //                                       minimumSize: const Size.fromHeight(44),
// //                                     ),
// //                                     onPressed: () {
// //                                       Navigator.of(context).push(
// //                                           MaterialPageRoute(
// //                                               builder: (context) =>
// //                                                   Login_page()));
// //                                     },
// //                                     child: const Text(
// //                                       'Cancel',
// //                                       style: TextStyle(
// //                                         fontSize: 16,
// //                                         fontFamily: 'IBMPlexSans',
// //                                         fontWeight: FontWeight.w500,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               });
// //         },
// //       ),
// //     );
// //   }
// // }
