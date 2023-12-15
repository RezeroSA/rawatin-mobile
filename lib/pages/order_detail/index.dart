import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/pages/buat_pesanan/index.dart';
import 'package:rawatin/pages/cari_alamat/index.dart';
import 'package:rawatin/pages/order_page/index.dart';
import 'package:rawatin/pages/payment_method/index.dart';
import 'package:rawatin/utils/utils.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  static const LatLng _initialCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);
  static const LatLng _uibCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  border: Border.all(width: 1, color: RawatinColorTheme.orange),
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
                      text: 'Detail pesanan',
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
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: RawatinColorTheme.black,
                                    fontSize: 14),
                                text: 'Jenis Layanan',
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
                                text: 'Cuci Mobil',
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
                                text: 'Petugas',
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
                                text: 'Philander',
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
                                text: 'Waktu Pemesanan',
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
                                text: '16.15',
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
              Container(
                width: double.maxFinite,
                height: 2,
                decoration: const BoxDecoration(
                    color: RawatinColorTheme.secondaryGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                      text: 'Detail pembayaran',
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
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: RawatinColorTheme.black,
                                    fontSize: 14),
                                text: 'Layanan Cuci Mobil - Cuci dirumah',
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
                    dashColor: RawatinColorTheme.secondaryGrey,
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
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: RawatinColorTheme.black,
                              fontSize: 14,
                              fontFamily: 'Arial Rounded'),
                          text: 'Rp 25.000',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
