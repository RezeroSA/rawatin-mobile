import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/utils/utils.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Ganti Bahasa',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Image(image: AssetsLocation.imageLocation('ganti-bahasa')),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilihan Bahasa',
                  style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 1,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: RawatinColorTheme.secondaryGrey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: RawatinColorTheme.secondaryGrey))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        _autentikasiBiometrik(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                'ID',
                                height: 25,
                                width: 35,
                                borderRadius: 4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Indonesia',
                                  style: TextStyle(
                                      // fontFamily: 'Arial Rounded',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: RawatinColorTheme.black)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "radio value",
                                  groupValue: "group value",
                                  onChanged: (value) {
                                    print(value); //selected value
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: RawatinColorTheme.secondaryGrey))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        _autentikasiBiometrik(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                'US',
                                height: 25,
                                width: 35,
                                borderRadius: 4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('English',
                                  style: TextStyle(
                                      // fontFamily: 'Arial Rounded',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: RawatinColorTheme.black)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "radio value",
                                  groupValue: "group value",
                                  onChanged: (value) {
                                    print(value); //selected value
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

_autentikasiBiometrik(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              surfaceTintColor: RawatinColorTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 420),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      ),
                      const Text(
                        'Berhasil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Arial Rounded',
                        ),
                      ),
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      ),
                      const Text(
                        'PIN kamu berhasil diubah',
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Image(
                            image:
                                AssetsLocation.imageLocation('ganti-bahasa')),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.orange,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: Text('Selesai',
                            style: RawatinColorTheme
                                .secondaryTextTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
