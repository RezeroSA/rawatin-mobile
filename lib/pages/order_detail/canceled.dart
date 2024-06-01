import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Canceled extends StatefulWidget {
  Canceled({super.key, required this.orderId});
  final int orderId;

  @override
  State<Canceled> createState() => _CanceledState();
}

class _CanceledState extends State<Canceled> {
  OrderService _orderService = Get.put(OrderService());
  bool _isLoading = false;
  int orderId = 0;
  String petugas = '';
  String phonePetugas = '';
  double rating = 0;
  double submitedRating = 0;
  String review = '';
  String layanan = '';
  double service_fee = 0;
  double transport_fee = 8000;
  double total = 0;
  String location = '';
  String alasanBatal = '';
  LatLng _latLong = LatLng(0, 0);

  Future getDetail() async {
    setState(() {
      _isLoading = true;
    });
    var res = await _orderService.detailCanceledOrder(orderId: widget.orderId);
    final order = res.data['data']['order'];
    final officer = res.data['data']['officer'] != null
        ? res.data['data']['officer']
        : null;

    setState(() {
      petugas = officer != null ? officer['name'] : '';
      phonePetugas = officer != null ? officer['phone'] : '';
      rating = order['rating'] != null ? order['rating'] + 0.0 : 0 + 0.0;
      review = order['customer_notes'] != null ? order['customer_notes'] : '';
      layanan = order['name'];
      service_fee = order['service_fee'] + 0.0;
      transport_fee = order['transport_fee'] + 0.0;
      total = order['total'] + 0.0;
      _latLong = LatLng(order['latitude'], order['longitude']);
      orderId = order['id'];
      alasanBatal = order['cancelled_reason'];
    });
  }

  Future<void> _getLocationUpdate(position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        location = placemarks[0].name! +
            ', ' +
            placemarks[0].subLocality! +
            ', ' +
            placemarks[0].locality! +
            ', ' +
            placemarks[0].administrativeArea!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail().then((value) => _getLocationUpdate(_latLong));
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatter serviceFee = MoneyFormatter(
        amount: service_fee,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter transportFee = MoneyFormatter(
        amount: transport_fee,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter totall = MoneyFormatter(
        amount: total,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));

    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Pesanan Saya',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: _isLoading,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 130,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: RawatinColorTheme.secondaryOrange,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: RawatinColorTheme.orange),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                  width: 280,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    location + location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: RawatinColorTheme.black,
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 15),
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
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: RawatinColorTheme.black,
                            fontFamily: 'Arial Rounded',
                            fontSize: 20),
                        text: 'Detail Pesanan',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'Rp ${serviceFee.output.withoutFractionDigits}',
                                ),
                              ],
                            ),
                          ),
                        ],
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
                                      'Rp ${transportFee.output.withoutFractionDigits}',
                                ),
                              ],
                            ),
                          ),
                        ],
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
                const SizedBox(
                  height: 15,
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
                                fontSize: 14,
                                fontFamily: 'Arial Rounded'),
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
                                fontSize: 14,
                                fontFamily: 'Arial Rounded'),
                            text: 'Rp ${totall.output.withoutFractionDigits}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: RawatinColorTheme.black,
                            fontFamily: 'Arial Rounded',
                            fontSize: 20),
                        text: 'Alasan Batal',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 4,
                  enabled: false,
                  initialValue: alasanBatal,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: RawatinColorTheme.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: RawatinColorTheme.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: RawatinColorTheme.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                // Container(
                //   width: double.maxFinite,
                //   height: 2,
                //   decoration: const BoxDecoration(
                //       color: RawatinColorTheme.orange,
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                // ),
                const SizedBox(
                  height: 30,
                ),
                petugas != ''
                    ? Container(
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
                                      image: AssetsLocation.imageLocation(
                                          'petugas'),
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
                                            Container(
                                              width: 200,
                                              child: Text(petugas),
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(phonePetugas),
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
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
