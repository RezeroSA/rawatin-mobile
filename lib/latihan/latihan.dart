import 'package:flutter/material.dart';
import 'package:rawatin/pages/auth_login/index.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/pages/welcome_page/index.dart';
import 'package:rawatin/utils/utils.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Dashboard',
      style: optionStyle,
    ),
    Text(
      'Index 2: Account',
      style: optionStyle,
    ),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var pageAll = [const AuthLogin(), const Register(), const WelcomePage()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Home'),
        ),
        body: pageAll[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: RawatinColorTheme.orange,
          onTap: (i) => setState(() => _selectedIndex = i),
        ),
      ),
    );

// class Latihan extends StatelessWidget {
//   const Latihan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
//         child: ListView(
//           children: [
//             TextButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                   backgroundColor: RawatinColorTheme.orange,
//                   context: context,
//                   isScrollControlled: true,
//                   isDismissible: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(16.0),
//                     ),
//                   ),
//                   builder: (BuildContext context) {
//                     return Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         ListTile(
//                           leading: const Icon(Icons.photo),
//                           title: const Text('Photo'),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.music_note),
//                           title: const Text('Music'),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.videocam),
//                           title: const Text('Video'),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.share),
//                           title: const Text('Share'),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: const Row(
//                 children: [
//                   Icon(
//                     Icons.key,
//                     color: RawatinColorTheme.orange,
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       'Show Modal',
//                       style: TextStyle(
//                           color: RawatinColorTheme.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Icon(
//                     Icons.abc,
//                     color: RawatinColorTheme.black,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
  }
}
