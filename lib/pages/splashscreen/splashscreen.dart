import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/pages/welcome_page/index.dart';
import 'package:rawatin/utils/utils.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    final box = GetStorage();
    print(box);
    var duration = const Duration(seconds: 2);

    if (box.read('token') != null) {
      return Timer(duration, () {
        Get.offAll(() => const Home());
      });
    } else {
      return Timer(duration, () {
        Get.offAll(() => const WelcomePage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetsLocation.imageLocation('logo'),
            width: 130,
          )
        ],
      )),
    );
  }
}
