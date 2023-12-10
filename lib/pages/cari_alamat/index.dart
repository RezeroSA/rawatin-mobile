import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rawatin/pages/cari_alamat/peta.dart';
import 'package:rawatin/utils/utils.dart';

class CariAlamat extends StatefulWidget {
  const CariAlamat({super.key});

  @override
  State<CariAlamat> createState() => _CariAlamatState();
}

class _CariAlamatState extends State<CariAlamat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Cari Alamat',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              ),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: TextFormField(
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: RawatinColorTheme.orange,
                    ),
                    labelText: 'Cari lokasi',
                    labelStyle: TextStyle(color: RawatinColorTheme.orange),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: RawatinColorTheme.orange),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: RawatinColorTheme.orange),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: RawatinColorTheme.orange),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: RawatinColorTheme.black,
                              fontFamily: 'Arial Rounded',
                              fontSize: 20),
                          text: 'Riwayat lokasi',
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const Peta(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: RawatinColorTheme.orange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.mapLocationDot,
                          color: RawatinColorTheme.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Pilih lewat peta',
                            style: RawatinColorTheme
                                .secondaryTextTheme.titleSmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 25,
                              color: RawatinColorTheme.orange,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Universitas Internasional Batam',
                                  style: TextStyle(
                                      fontFamily: 'Arial Rounded',
                                      fontSize: 17,
                                      color: RawatinColorTheme.black),
                                ),
                                Text(
                                  'Baloi-Sei Ladi, Jl. Gajah Mada, Tiban Indah, Kec...',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: RawatinColorTheme.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: RawatinColorTheme.orange,
                            ),
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 25,
                              color: RawatinColorTheme.orange,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Universitas Putera Batam',
                                  style: TextStyle(
                                      fontFamily: 'Arial Rounded',
                                      fontSize: 17,
                                      color: RawatinColorTheme.black),
                                ),
                                Text(
                                  'Jalan R. Soeprapto Muka Kuning, Kibing, Kec. Batu ...',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: RawatinColorTheme.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: RawatinColorTheme.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
