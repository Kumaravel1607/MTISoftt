// import 'package:flutter/material.dart';
// import 'package:google/notification_services.dart';
// import 'package:google/provider/google_singin.dart';
// import 'package:provider/provider.dart';

// class Login extends StatefulWidget {
//   Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [
//         ElevatedButton(
//             onPressed: () {
//               final provider =
//                   Provider.of<GoogleSignInProvider>(context, listen: false);
//               provider.logout();
//             },
//             child: Text('Logout'))
//       ]),
//       body: Center(
//         child: Container(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Hello Google"),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(22),
//                         ),
//                         side: const BorderSide(
//                             style: BorderStyle.solid,
//                             color: Colors.grey,
//                             width: 1),
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.black,
//                         fixedSize: const Size(200, 44),
//                         elevation: 0),
//                     onPressed: () {
//                       final provider = Provider.of<GoogleSignInProvider>(
//                           context,
//                           listen: false);
//                       provider.googleLogin();
//                       // Navigator.of(context).push(
//                       //     MaterialPageRoute(builder: (context) => HomeScreen()));
//                     },
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'lib/assets/google.png',
//                           height: 20,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         const Text("Sign with Google",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Rubik',
//                                 fontSize: 16))
//                       ],
//                     )),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text("Hello Facebook"),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(22),
//                         ),
//                         side: const BorderSide(
//                             style: BorderStyle.solid,
//                             color: Colors.grey,
//                             width: 1),
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.black,
//                         fixedSize: const Size(200, 44),
//                         elevation: 0),
//                     onPressed: () {
//                       final provider = Provider.of<GoogleSignInProvider>(
//                           context,
//                           listen: false);
//                       provider.signinWithFacebook(context);
//                       // Navigator.of(context).push(
//                       //     MaterialPageRoute(builder: (context) => HomeScreen()));
//                     },
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'lib/assets/fb.png',
//                           height: 20,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         const Text("Sign with Facebook",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Rubik',
//                                 fontSize: 16))
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
