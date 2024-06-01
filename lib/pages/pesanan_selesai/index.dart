import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PesananSelesai extends StatefulWidget {
  PesananSelesai({super.key});

  @override
  State<PesananSelesai> createState() => _PesananSelesaiState();
}

class _PesananSelesaiState extends State<PesananSelesai> {
  OrderService _orderService = Get.put(OrderService());
  int orderId = 0;
  bool _isLoading = true;
  bool _isLoadingOfficer = true;
  LatLng _latLong = LatLng(0, 0);
  String lokasiAsal = 'Bengkel Rawat.in';
  String lokasiTujuan = '';
  String petugas = '';
  String fotoPetugas = '';
  String Rating = '4.5';
  String layanan = '';
  String buktiGambar = '';
  double serviceFee = 0;
  double transportFee = 0;
  double total = 0;
  double platformFee = 2000;
  double rating = 0;
  double submitedRating = 0;
  String review = '';
  final box = GetStorage();
  GoogleMapController? _mapController;
  final controller = Completer<GoogleMapController>();

  Future<void> _getOrder() async {
    final res =
        await _orderService.getLastPesananSelesai(userId: box.read('phoneNum'));

    print(res);

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
        orderId = res['order']['id_order'];
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
        buktiGambar = res['order']['emergency_image'] != null
            ? res['order']['emergency_image']
            : '';
        fotoPetugas =
            res['officer']['avatar'] != null ? res['officer']['avatar'] : '';
        _isLoading = false;
        petugas = res['officer']['name'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getOrder();
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
    TextEditingController reviewController = TextEditingController();
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
                  Get.offAll(() => Home());
                },
              ),
            )),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true, //darken background if panel is open
        color: Colors
            .transparent, //necessary if you have rounded corners for panel
        /// panel itself
        minHeight: MediaQuery.of(context).size.height * 0.32,
        maxHeight: MediaQuery.of(context).size.height * 0.87,
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
                      Container(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      image: fotoPetugas == ''
                                          ? AssetsLocation.imageLocation(
                                              'petugas')
                                          : NetworkImage(
                                              '${onlineAssets}/storage/foto_profil/${fotoPetugas}'),
                                      // image: AssetsLocation.imageLocation(
                                      //     'jiro'),
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
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    style: TextStyle(
                                                        color: RawatinColorTheme
                                                            .black,
                                                        fontFamily:
                                                            'Arial Rounded',
                                                        fontSize: 20),
                                                    text: petugas,
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
                                  dashColor: Colors.orange,
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
                            margin: const EdgeInsets.symmetric(vertical: 15),
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
                                                color: RawatinColorTheme.black,
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
                                                color: RawatinColorTheme.black,
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
                                                color: RawatinColorTheme.black,
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
                                                color: RawatinColorTheme.black,
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
                                                color: RawatinColorTheme.black,
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
                                                color: RawatinColorTheme.black,
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
                            height: 10,
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
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: rating == 0
                                ? RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                              color: RawatinColorTheme.black,
                                              fontFamily: 'Arial Rounded',
                                              fontSize: 20),
                                          text: 'Kasih rating buat petugas',
                                        ),
                                      ],
                                    ),
                                  )
                                : RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                              color: RawatinColorTheme.black,
                                              fontFamily: 'Arial Rounded',
                                              fontSize: 20),
                                          text: 'Pesanan udah selesai',
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          rating == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star_border_rounded,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          setState(() {
                                            submitedRating = rating;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: reviewController,
                                        decoration: const InputDecoration(
                                          labelText:
                                              'Ucapin makasih ke petugas...',
                                          labelStyle: TextStyle(
                                              color: RawatinColorTheme.black),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    RawatinColorTheme.orange),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      RawatinColorTheme.orange),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if (submitedRating == 0) {
                                            ArtSweetAlert.show(
                                              context: context,
                                              artDialogArgs: ArtDialogArgs(
                                                  type:
                                                      ArtSweetAlertType.warning,
                                                  title: 'Ups',
                                                  text:
                                                      'Ratingnya belum kamu isi',
                                                  confirmButtonText:
                                                      'Oke, saya isi dulu',
                                                  confirmButtonColor:
                                                      RawatinColorTheme.orange),
                                            );
                                          } else {
                                            var res = await _orderService
                                                .submitRating(
                                                    orderId: orderId,
                                                    rating: submitedRating,
                                                    review:
                                                        reviewController.text);

                                            if (res == true) {
                                              setState(() {
                                                _isLoading = true;
                                                rating = submitedRating;
                                                review = reviewController.text;
                                              });
                                              _getOrder();
                                              ArtSweetAlert.show(
                                                  context: context,
                                                  artDialogArgs: ArtDialogArgs(
                                                    type: ArtSweetAlertType
                                                        .success,
                                                    title: 'Berhasil',
                                                    text:
                                                        'Cippp, review udah dimacukin',
                                                    confirmButtonText: 'OK',
                                                    confirmButtonColor:
                                                        RawatinColorTheme
                                                            .orange,
                                                  ));
                                            } else {
                                              ArtSweetAlert.show(
                                                  context: context,
                                                  artDialogArgs: ArtDialogArgs(
                                                    type: ArtSweetAlertType
                                                        .danger,
                                                    title: 'Ups',
                                                    text:
                                                        'Terjadi kesalahan waktu mengirim review, coba lagi yaaa',
                                                    confirmButtonText: 'OK',
                                                    confirmButtonColor:
                                                        RawatinColorTheme
                                                            .orange,
                                                  ));
                                            }
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(40),
                                          backgroundColor:
                                              RawatinColorTheme.orange,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        child: Text('Simpan',
                                            style: RawatinColorTheme
                                                .secondaryTextTheme.titleSmall),
                                      ),
                                    ])
                              : Column(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: rating,
                                      minRating: 1,
                                      ignoreGestures: true,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star_border_rounded,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      // controller: reviewController,
                                      initialValue: review,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Ucapin makasih ke petugas...',
                                        labelStyle: TextStyle(
                                            color: RawatinColorTheme.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: RawatinColorTheme.orange),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    RawatinColorTheme.orange),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
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
                      Container(
                        child: SizedBox(
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
                                      image: fotoPetugas == ''
                                          ? AssetsLocation.imageLocation(
                                              'petugas')
                                          : NetworkImage(
                                              '${onlineAssets}/storage/foto_profil/${fotoPetugas}'),
                                      // image: AssetsLocation.imageLocation(
                                      //     'jiro'),
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
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    style: TextStyle(
                                                        color: RawatinColorTheme
                                                            .black,
                                                        fontFamily:
                                                            'Arial Rounded',
                                                        fontSize: 20),
                                                    text: petugas,
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
