import 'package:flutter/material.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Dashboard.dart';
import 'package:google/History.dart';
import 'package:google/Password.dart';
import 'package:google/Leave_request.dart';
import 'package:google/Profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
//   var tabIndex = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   void changeTab(int index) {
//     setState(() {
//       tabIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       resizeToAvoidBottomInset: false,
//       body: IndexedStack(
//         index: tabIndex,
//         children: [
//           DashBoard_Screen(),
//           History_Screen(),
//           LeaveRequest(),
//           Profile(),
//           Logout()
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         clipBehavior: Clip.antiAlias,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 4,
//         child: BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           type: BottomNavigationBarType.fixed,
//           selectedFontSize: 12,
//           currentIndex: tabIndex,
//           onTap: changeTab,
//           selectedItemColor: Blue,
//           unselectedItemColor: greytext,
//           showSelectedLabels: true,
//           showUnselectedLabels: false,
//           items: [
//             itemBar(Icons.home_outlined, 'Home'),
//             itemBar(Icons.assignment, 'History'),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent,
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.transparent,
//               ),
//               label: '',
//             ),
//             // itemBar(Icons.maps_ugc, 'New Request',),
//             itemBar(Icons.account_circle, 'My Profile'),
//             itemBar(Icons.logout_outlined, 'Logout'),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         //mini: true,
//         backgroundColor: Blue,
//         focusColor: Colors.transparent,
//         onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(
//                 builder: (BuildContext context) => LeaveRequest()),
//             (Route<dynamic> route) => false),
//         // Navigator.of(context)
//         //     .push(MaterialPageRoute(builder: (context) => Request_Form())),
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// itemBar(IconData icon, String label) {
//   return BottomNavigationBarItem(icon: Icon(icon), label: label);
// }

//   PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarItems(),
//       confineInSafeArea: true,
//       itemAnimationProperties: const ItemAnimationProperties(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: const ScreenTransitionAnimation(
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//           animateTabTransition: true),
//       navBarStyle: NavBarStyle.style15,
//     );
//   }
// }

// List<PersistentBottomNavBarItem> _navBarItems() {
//   return [
//     PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.home,
//         color: Blue,
//       ),
//       title: ('Home'),
//       activeColorPrimary: Colors.blue.shade800,
//       inactiveColorPrimary: Colors.grey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.home,
//         color: Blue,
//       ),
//       title: ('Home'),
//       activeColorPrimary: Colors.blue.shade800,
//       inactiveColorPrimary: Colors.grey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.list_alt,
//         color: Blue,
//       ),
//       title: ('History'),
//       activeColorPrimary: Colors.blue.shade800,
//       inactiveColorPrimary: Colors.grey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.groups,
//         color: Blue,
//       ),
//       title: ('Students'),
//       activeColorPrimary: Colors.blue.shade800,
//       inactiveColorPrimary: Colors.grey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.logout,
//         color: Blue,
//       ),
//       title: ('Logout'),
//       activeColorPrimary: Colors.blue.shade800,
//       inactiveColorPrimary: Colors.grey,
//     ),
//   ];
// }

// List<Widget> _buildScreens() {
//   return [
//     DashBoard_Screen(),
//     History_Screen(),
//     LeaveRequest(),
//     Profile(),
//     Logout()
//   ];
// }

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        DashBoard_Screen(),
        History_Screen(),
        LeaveRequest(),
        Profile(),
        Password()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          title: ("Home"),
          activeColorPrimary: Blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.assignment_outlined),
          title: ("History"),
          activeColorPrimary: Blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Colors.white),
          activeColorPrimary: Blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          title: ("My Profile"),
          activeColorPrimary: Blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.lock_outlined),
          title: ("Password"),
          activeColorPrimary: Blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
