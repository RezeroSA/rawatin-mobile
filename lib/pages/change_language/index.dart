import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/utils/utils.dart';

// ignore: must_be_immutable
class ChangeLanguage extends StatefulWidget {
  ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  int type = 1;

  @override
  Widget build(BuildContext context) {
    void handleRadio(Object? e) {
      if (e == 2) {
        return ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: 'Upss',
                text: 'Saat ini hanya tersedia bahasa indonesia :(',
                confirmButtonText: 'Oke, gapapa',
                confirmButtonColor: RawatinColorTheme.orange));
      } else {
        type = e as int;
      }
    }

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
                        handleRadio(1);
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
                                  activeColor: RawatinColorTheme.orange,
                                  value: 1,
                                  groupValue: type,
                                  onChanged: (value) {
                                    handleRadio(value);
                                  }),
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
                        handleRadio(2);
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
                                  value: 2,
                                  activeColor: RawatinColorTheme.orange,
                                  groupValue: type,
                                  onChanged: (value) {
                                    handleRadio(value);
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
