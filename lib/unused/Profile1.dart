// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google/provider/google_singin.dart';
// import 'package:provider/provider.dart';

// class Profile extends StatefulWidget {
//   Profile({Key? key}) : super(key: key);

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           ElevatedButton(
//               onPressed: () {
//                 final provider =
//                     Provider.of<GoogleSignInProvider>(context, listen: false);
//                 provider.logout();
//               },
//               child: Text('Logout'))
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundImage: NetworkImage(user.photoURL!),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Username:  " + user.displayName!,
//             style: TextStyle(color: Colors.black, fontSize: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }
