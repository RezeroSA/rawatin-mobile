import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rawatin/components/top_logo.dart';
import 'package:rawatin/pages/login/index.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:geolocator/geolocator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<Position> _getPositionAccess() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Rawat.in membutuhkan akses lokasi agar berfungsi dengan baik',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Rawat.in membutuhkan akses lokasi agar berfungsi dengan baik',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Rawat.in membutuhkan akses lokasi agar berfungsi dengan baik',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // print(await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    // Panggil fungsi yang ingin dijalankan saat halaman dimuat
    _getPositionAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: RawatinColorTheme.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const TopLogo(),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0),
                child: Column(
                  children: [
                    Image(
                      image: AssetsLocation.imageLocation('welcome_page'),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04),
                child: const Column(
                  children: [
                    Text('Selamat datang di Rawat.in',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Arial Rounded')),
                    Text(
                      'Aplikasi yang buat kendaraan kamu jadi terawat. Siap bantu rawat kendaraan kamu mulai dari servis, cuci, hingga panggilan darurat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: RawatinColorTheme.orange,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: Text('Masuk',
                          style:
                              RawatinColorTheme.secondaryTextTheme.titleSmall),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: RawatinColorTheme.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        side: const BorderSide(color: RawatinColorTheme.orange),
                      ),
                      child: Text(
                        'Belum ada akun? Daftar dulu',
                        style: RawatinColorTheme.primaryTextTheme.titleSmall,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
