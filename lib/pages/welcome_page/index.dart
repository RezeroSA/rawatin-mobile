import 'package:flutter/material.dart';
import 'package:rawatin/components/top_logo.dart';
import 'package:rawatin/pages/login/login.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/utils/utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: RawatinColorTheme.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const TopLogo(),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0),
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
                      style:
                          TextStyle(fontSize: 24, fontFamily: 'Arial Rounded')),
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
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: RawatinColorTheme.orange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Text('Masuk',
                        style: RawatinColorTheme.secondaryTextTheme.titleSmall),
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
    );
  }
}
