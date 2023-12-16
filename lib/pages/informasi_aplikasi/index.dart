import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class InformasiAplikasi extends StatelessWidget {
  const InformasiAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Informasi Aplikasi',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'This app was made using Flutter',
                    style: TextStyle(fontSize: 20, fontFamily: 'Arial Rounded'),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetsLocation.imageLocation('logo'),
                          height: 150,
                        ),
                        const Text(
                          'X',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w100),
                        ),
                        Image(
                          image: AssetsLocation.imageLocation('flutter'),
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 25),
                    child: Text(
                      'Made with ❤️ by:',
                      style: TextStyle(
                        fontFamily: 'Arial Rounded',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        'Sandy Alferro Dion - 2131080',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Alika Naziera Wardani - 2131080',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Nurhikmah Ibrahim - 204855091',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Philander Alvando Davian - 2131103',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Ricky Fernando - 2131057',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Andrian Muhammad Ramdhan - 21573008',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'App ver 1.0',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
