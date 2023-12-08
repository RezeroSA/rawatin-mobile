import 'package:flutter/material.dart';
import 'package:rawatin/components/nav_model.dart';
import 'package:rawatin/components/navbar.dart';
import 'package:rawatin/pages/home/emergency_page.dart';
import 'package:rawatin/pages/home/home_page.dart';
import 'package:rawatin/pages/home/order_page.dart';
import 'package:rawatin/pages/home/profile_page.dart';
import 'package:rawatin/pages/notification/index.dart';
import 'package:rawatin/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late SMIBool homeTrigger;
  final homeNavKey = GlobalKey<NavigatorState>();
  final warningNavKey = GlobalKey<NavigatorState>();
  final orderNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: const TabPage(tab: 1), navKey: homeNavKey),
      NavModel(page: const TabPage(tab: 2), navKey: warningNavKey),
      NavModel(page: const TabPage(tab: 3), navKey: orderNavKey),
      NavModel(page: const TabPage(tab: 4), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: RawatinColorTheme.white,
        surfaceTintColor: RawatinColorTheme.white,
        scrolledUnderElevation: 0.0,
        leading: Image(
          image: AssetsLocation.imageLocation('logo'),
        ),
        leadingWidth: 100,
        backgroundColor: RawatinColorTheme.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => NotitcationTap(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none,
                size: 30,
              ))
        ],
        centerTitle: true,
      ),
      body: () {
        if (tab == 1) {
          return HomePage();
        } else if (tab == 2) {
          return const EmergencyPage();
        } else if (tab == 3) {
          return const OrderPage();
        } else if (tab == 4) {
          return const ProfilePage();
        }
      }(),
    );
  }
}
