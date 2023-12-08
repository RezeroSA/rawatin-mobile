import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rawatin/pages/change_language/index.dart';
import 'package:rawatin/pages/ganti_pin/index.dart';
import 'package:rawatin/pages/informasi_aplikasi/index.dart';
import 'package:rawatin/pages/order_page/index.dart';
import 'package:rawatin/pages/welcome_page/index.dart';
import 'package:rawatin/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final orderNavKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Padding(padding: EdgeInsets.fromLTRB(0, 35, 0, 10)),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(
                        color: RawatinColorTheme.black,
                        fontFamily: 'Arial Rounded',
                        fontSize: 30),
                    text: 'Akun saya',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetsLocation.imageLocation('nahoko'),
                      height: 110.0,
                      width: 110.0,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: RawatinColorTheme.black,
                                    fontFamily: 'Arial Rounded',
                                    fontSize: 30),
                                text: 'Alika Naziera',
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'alikanaziera@gmail.com',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Text(
                          '+62 851 5799 1015',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Icon(Icons.edit)],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(
                        color: RawatinColorTheme.black,
                        fontFamily: 'Arial Rounded',
                        fontSize: 25),
                    text: 'Akun',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: ListView(
                children: [
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
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const OrderPageMain(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 25,
                                  color: RawatinColorTheme.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Pesanan',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Cek riwayat & pesanan aktif',
                                    style: TextStyle(
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
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
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const ChangeLanguage(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  size: 25,
                                  color: RawatinColorTheme.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Ganti Bahasa',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
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
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const GantiPin(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.key,
                                  size: 25,
                                  color: RawatinColorTheme.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Ganti PIN',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 2),
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //         border: Border(
                  //             bottom: BorderSide(
                  //                 width: 1,
                  //                 color: RawatinColorTheme.secondaryGrey))),
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         padding: EdgeInsets.zero,
                  //       ),
                  //       onPressed: () {},
                  //       child: const Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.help_outline,
                  //                 size: 25,
                  //                 color: RawatinColorTheme.black,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text('FAQ',
                  //                   style: TextStyle(
                  //                       fontFamily: 'Arial Rounded',
                  //                       fontSize: 17,
                  //                       color: RawatinColorTheme.black)),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.arrow_forward_ios,
                  //                 color: RawatinColorTheme.black,
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 2),
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //         border: Border(
                  //             bottom: BorderSide(
                  //                 width: 1,
                  //                 color: RawatinColorTheme.secondaryGrey))),
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         padding: EdgeInsets.zero,
                  //       ),
                  //       onPressed: () {},
                  //       child: const Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               FaIcon(
                  //                 FontAwesomeIcons.solidLifeRing,
                  //                 color: RawatinColorTheme.black,
                  //                 size: 22,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text('Pusat Bantuan',
                  //                   style: TextStyle(
                  //                       fontFamily: 'Arial Rounded',
                  //                       fontSize: 17,
                  //                       color: RawatinColorTheme.black)),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.arrow_forward_ios,
                  //                 color: RawatinColorTheme.black,
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                          _rating(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 25,
                                  color: RawatinColorTheme.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Beri Kami Nilai',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
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
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const InformasiAplikasi(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.info,
                                  size: 20,
                                  color: RawatinColorTheme.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Informasi Aplikasi',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.black)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
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
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const WelcomePage(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 25,
                                  color: RawatinColorTheme.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Keluar',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 17,
                                        color: RawatinColorTheme.red)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: RawatinColorTheme.black,
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
          ],
        ),
      ),
    );
  }
}

_rating(context) {
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
                        'Beri Kami Nilai',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Arial Rounded',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Image(
                            image: AssetsLocation.imageLocation('rating')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_border_rounded,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.grey,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: const Text('Selesai',
                            style: TextStyle(
                                fontFamily: 'Arial Rounded',
                                fontSize: 15,
                                color: RawatinColorTheme.orange)),
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
