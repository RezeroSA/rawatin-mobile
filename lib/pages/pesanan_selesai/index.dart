import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PesananSelesai extends StatefulWidget {
  const PesananSelesai({super.key});

  @override
  State<PesananSelesai> createState() => _PesananSelesaiState();
}

class _PesananSelesaiState extends State<PesananSelesai> {
  static const LatLng _initialCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);
  static const LatLng _uibCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 5, blurStyle: BlurStyle.normal),
                ],
              ),
              child: IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                icon: const Icon(Icons
                    .arrow_back_ios_new_sharp), // Put icon of your preference.
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true, //darken background if panel is open
        color: Colors
            .transparent, //necessary if you have rounded corners for panel
        /// panel itself
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        panel: Container(
          decoration: const BoxDecoration(
            // background color of panel
            color: RawatinColorTheme.white,
            // rounded corners of panel
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              const BarIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 1,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: AssetsLocation.imageLocation('jiro'),
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Petugas',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arial Rounded',
                                              color: RawatinColorTheme
                                                  .secondaryGrey,
                                            ),
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: RawatinColorTheme
                                                          .black,
                                                      fontFamily:
                                                          'Arial Rounded',
                                                      fontSize: 20),
                                                  text: 'Sandy Alferro',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: RawatinColorTheme
                                                    .secondaryGrey,
                                                size: 20,
                                              ),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Arial Rounded',
                                                    color: RawatinColorTheme
                                                        .secondaryGrey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _rating(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: RawatinColorTheme.orange,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    child: Text('Beri rating',
                                        style: RawatinColorTheme
                                            .secondaryTextTheme.titleSmall),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.warehouse,
                                color: RawatinColorTheme.black,
                                size: 18,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15),
                                        text: 'Bengkel Rawat.in',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Dash(
                                  direction: Axis.vertical,
                                  length: 30,
                                  dashLength: 3,
                                  dashColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.pin_drop_outlined,
                                color: RawatinColorTheme.black,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15),
                                        text: 'Universitas Internasional Batam',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: const SizedBox(
                          width: double.maxFinite,
                          height: 2,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: FittedBox(
                              child: Dash(
                                direction: Axis.horizontal,
                                dashLength: 4,
                                dashColor: RawatinColorTheme.orange,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                      color: RawatinColorTheme.black,
                                      fontFamily: 'Arial Rounded',
                                      fontSize: 18),
                                  text: 'Ringkasan pesanan',
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text:
                                                'Layanan Cuci Mobil - Cuci dirumah',
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text: 'Rp 15.000',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text: 'Biaya transport petugas',
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text: 'Rp 8.000',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text: 'Biaya platform',
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontSize: 14),
                                            text: 'Rp 2.000',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: double.maxFinite,
                            child: FittedBox(
                              child: Dash(
                                direction: Axis.horizontal,
                                dashLength: 4,
                                dashColor: RawatinColorTheme.orange,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 14),
                                        text: 'Total',
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 14),
                                        text: 'Rp 35.000',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// header of panel while collapsed
        collapsed: Container(
          decoration: const BoxDecoration(
            color: RawatinColorTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              const BarIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 1,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: AssetsLocation.imageLocation('jiro'),
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Petugas',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arial Rounded',
                                              color: RawatinColorTheme
                                                  .secondaryGrey,
                                            ),
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: RawatinColorTheme
                                                          .black,
                                                      fontFamily:
                                                          'Arial Rounded',
                                                      fontSize: 20),
                                                  text: 'Sandy Alferro',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: RawatinColorTheme
                                                    .secondaryGrey,
                                                size: 20,
                                              ),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Arial Rounded',
                                                    color: RawatinColorTheme
                                                        .secondaryGrey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _rating(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: RawatinColorTheme.orange,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    child: Text('Beri rating',
                                        style: RawatinColorTheme
                                            .secondaryTextTheme.titleSmall),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.warehouse,
                                color: RawatinColorTheme.black,
                                size: 18,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15),
                                        text: 'Bengkel Rawat.in',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Dash(
                                  direction: Axis.vertical,
                                  length: 30,
                                  dashLength: 3,
                                  dashColor: RawatinColorTheme.orange,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.pin_drop_outlined,
                                color: RawatinColorTheme.black,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15),
                                        text: 'Universitas Internasional Batam',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// widget behind panel
        body: Scaffold(
            body: Stack(
          children: [
            Image(
              image: AssetsLocation.imageLocation('background-done'),
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: RawatinColorTheme.black,
                                fontFamily: 'Arial Rounded',
                                fontSize: 25),
                            text: 'Pesanan kamu sudah selesai',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.001,
                      ),
                      child: Image(
                        image: AssetsLocation.imageLocation('done'),
                        width: 400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 50,
        height: 4,
        decoration: const BoxDecoration(
          color: RawatinColorTheme.secondaryGrey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                constraints: const BoxConstraints(maxHeight: 300),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: AssetsLocation.imageLocation('jiro'),
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Petugas',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arial Rounded',
                                              color: RawatinColorTheme
                                                  .secondaryGrey,
                                            ),
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: RawatinColorTheme
                                                          .black,
                                                      fontFamily:
                                                          'Arial Rounded',
                                                      fontSize: 20),
                                                  text: 'Sandy Alferro',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: RawatinColorTheme
                                                    .secondaryGrey,
                                                size: 20,
                                              ),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Arial Rounded',
                                                    color: RawatinColorTheme
                                                        .secondaryGrey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                          ),
                          const Text(
                            'Berikan rating',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Arial Rounded',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
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
                              Navigator.pop(context);
                              Navigator.pop(context);
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
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
