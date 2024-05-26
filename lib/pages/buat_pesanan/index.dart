import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rawatin/pages/home/home_page.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/pages/pesanan_selesai/index.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:typing_text/typing_text.dart';

class BuatPesanan extends StatefulWidget {
  const BuatPesanan({super.key});

  @override
  State<BuatPesanan> createState() => _BuatPesananState();
}

class _BuatPesananState extends State<BuatPesanan> {
  OrderService _orderService = Get.put(OrderService());
  bool _isLoading = true;
  bool _isLoadingOfficer = true;
  LatLng _latLong = LatLng(0, 0);
  String lokasiAsal = 'Bengkel Rawat.in';
  String lokasiTujuan = '';
  String petugas = '';
  String Rating = '4.5';
  String layanan = '';
  double serviceFee = 0;
  double transportFee = 0;
  double total = 0;
  double platformFee = 2000;
  final box = GetStorage();
  GoogleMapController? _mapController;
  final controller = Completer<GoogleMapController>();

  Future<void> _getOrder() async {
    final res =
        await _orderService.getOrderByUser(userId: box.read('phoneNum'));

    if (res != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        res['order']['latitude'],
        res['order']['longitude'],
      );
      CameraPosition newPosition = CameraPosition(
        target: LatLng(res['order']['latitude'], res['order']['longitude']),
        zoom: 17.0,
      );
      _mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
      setState(() {
        _latLong = LatLng(res['order']['latitude'], res['order']['longitude']);
        layanan = res['order']['name'];
        serviceFee = double.parse(res['order']['service_fee'].toString());
        transportFee = double.parse(res['order']['transport_fee'].toString());
        total = double.parse(res['order']['total'].toString());
        lokasiTujuan = placemarks[0].name! +
            ', ' +
            placemarks[0].subLocality! +
            ', ' +
            placemarks[0].locality! +
            ', ' +
            placemarks[0].administrativeArea!;
        _isLoading = false;
      });
    }
  }

  void _getOfficer() async {
    final res =
        await _orderService.getOrderByUser(userId: box.read('phoneNum'));
    if (res != null) {
      if (res['order']['officer_id'] == null ||
          res['order']['officer_id'] == '') {
        Future.delayed(const Duration(seconds: 5), () {
          _getOfficer();
        });
      } else {
        setState(() {
          _isLoadingOfficer = false;
          petugas = res['officer']['name'];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getOrder().then((value) => _getOfficer());
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatter service_fee = MoneyFormatter(
        amount: serviceFee,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter transport_fee = MoneyFormatter(
        amount: transportFee,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter platform_fee = MoneyFormatter(
        amount: platformFee,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter totals = MoneyFormatter(
        amount: total,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
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
                  Get.to(() => Home());
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
                child: Skeletonizer(
                  enabled: _isLoading,
                  child: Container(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _isLoadingOfficer
                              ? Container(
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width * 1,
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetsLocation
                                                    .imageLocation('petugas'),
                                                height: 80.0,
                                                width: 80.0,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              height: 80,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Petugas',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'Arial Rounded',
                                                          color:
                                                              RawatinColorTheme
                                                                  .secondaryGrey,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: TypingText(
                                                          words: [
                                                            'Mencari petugas...',
                                                            'Tunggu bentar yaa',
                                                            'Pesanan lagi ramai nih',
                                                            'Kita udah buat kamu menjadi antrian prioritas',
                                                          ],
                                                          letterSpeed: Duration(
                                                              milliseconds: 30),
                                                          wordSpeed: Duration(
                                                              milliseconds:
                                                                  1000),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
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
                                )
                              : Container(
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width * 1,
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetsLocation
                                                    .imageLocation('jiro'),
                                                height: 80.0,
                                                width: 80.0,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              height: 80,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Petugas',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'Arial Rounded',
                                                          color:
                                                              RawatinColorTheme
                                                                  .secondaryGrey,
                                                        ),
                                                      ),
                                                      RichText(
                                                        text: const TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              style: TextStyle(
                                                                  color:
                                                                      RawatinColorTheme
                                                                          .black,
                                                                  fontFamily:
                                                                      'Arial Rounded',
                                                                  fontSize: 20),
                                                              text:
                                                                  'Sandy Alferro',
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
                                                                fontFamily:
                                                                    'Arial Rounded',
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const PesananSelesai(),
                                                  ),
                                                );
                                              },
                                              style: const ButtonStyle(
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                              ),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      RawatinColorTheme.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        blurStyle:
                                                            BlurStyle.normal),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.call,
                                                  color:
                                                      RawatinColorTheme.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontFamily: 'Arial Rounded',
                                                fontSize: 15),
                                            text: lokasiTujuan,
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text: layanan,
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text:
                                                    'Rp ${service_fee.output.withoutFractionDigits}',
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
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text: 'Biaya transport petugas',
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text:
                                                    'Rp ${transport_fee.output.withoutFractionDigits}',
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
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text: 'Biaya platform',
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color:
                                                        RawatinColorTheme.black,
                                                    fontSize: 14),
                                                text:
                                                    'Rp ${platform_fee.output.withoutFractionDigits}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontFamily: 'Arial Rounded',
                                                fontSize: 14),
                                            text:
                                                'Rp ${totals.output.withoutFractionDigits}',
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
                ),
              ),
            ],
          ),
        ),

        /// header of panel while collapsed
        collapsed: Skeletonizer(
          enabled: _isLoading,
          child: Container(
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
                        _isLoadingOfficer
                            ? Container(
                                child: SizedBox(
                                  // width: MediaQuery.of(context).size.width * 1,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              image:
                                                  AssetsLocation.imageLocation(
                                                      'petugas'),
                                              height: 80.0,
                                              width: 80.0,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 80,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        fontFamily:
                                                            'Arial Rounded',
                                                        color: RawatinColorTheme
                                                            .secondaryGrey,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      child: TypingText(
                                                        words: [
                                                          'Mencari petugas...',
                                                          'Tunggu bentar yaa',
                                                          'Pesanan lagi ramai nih',
                                                          'Kita udah buat kamu menjadi antrian prioritas',
                                                        ],
                                                        letterSpeed: Duration(
                                                            milliseconds: 30),
                                                        wordSpeed: Duration(
                                                            milliseconds: 1000),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
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
                              )
                            : Container(
                                child: SizedBox(
                                  // width: MediaQuery.of(context).size.width * 1,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              image:
                                                  AssetsLocation.imageLocation(
                                                      'jiro'),
                                              height: 80.0,
                                              width: 80.0,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 80,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        fontFamily:
                                                            'Arial Rounded',
                                                        color: RawatinColorTheme
                                                            .secondaryGrey,
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: const TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            style: TextStyle(
                                                                color:
                                                                    RawatinColorTheme
                                                                        .black,
                                                                fontFamily:
                                                                    'Arial Rounded',
                                                                fontSize: 20),
                                                            text:
                                                                'Sandy Alferro',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              RawatinColorTheme
                                                                  .secondaryGrey,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          '4.5',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Arial Rounded',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const PesananSelesai(),
                                                ),
                                              );
                                            },
                                            style: const ButtonStyle(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                            ),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                color: RawatinColorTheme.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 2,
                                                      blurStyle:
                                                          BlurStyle.normal),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.call,
                                                color: RawatinColorTheme.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                              color: RawatinColorTheme.black,
                                              fontFamily: 'Arial Rounded',
                                              fontSize: 15),
                                          text: lokasiTujuan,
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
        ),

        /// widget behind panel
        body: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.7,
          child: GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _latLong,
              zoom: 17,
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                  markerId: MarkerId("demo"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _latLong),
            },
          ),
        ),
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
