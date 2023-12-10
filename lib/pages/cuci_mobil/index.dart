import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/pages/auth_register/index.dart';
import 'package:rawatin/pages/cari_alamat/index.dart';
import 'package:rawatin/pages/order_page/index.dart';
import 'package:rawatin/utils/utils.dart';

class CuciMobil extends StatefulWidget {
  const CuciMobil({super.key});

  @override
  State<CuciMobil> createState() => _CuciMobilState();
}

class _CuciMobilState extends State<CuciMobil> {
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
          'Cuci Mobil',
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
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      style: TextStyle(
                          color: RawatinColorTheme.black,
                          fontFamily: 'Arial Rounded',
                          fontSize: 20),
                      text: 'Pilih Layanan',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: RawatinColorTheme.secondaryOrange,
                    borderRadius: BorderRadius.circular(10)),
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
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Positioned(
                                    bottom: 15,
                                    child: Icon(
                                      FontAwesomeIcons.houseChimney,
                                      size: 25,
                                      color: RawatinColorTheme.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, top: 20),
                                    child: Icon(
                                      FontAwesomeIcons.car,
                                      color: RawatinColorTheme.orange,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 170,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cuci dirumah',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 16,
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Harga lebih murah. Pastikan dirumah kamu ada air ya',
                                    style: TextStyle(
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp 15.000',
                              style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 18,
                                  color: RawatinColorTheme.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Rp 25.000',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: RawatinColorTheme.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: RawatinColorTheme.white,
                    borderRadius: BorderRadius.circular(10)),
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
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Positioned(
                                    bottom: 15,
                                    child: Icon(
                                      FontAwesomeIcons.warehouse,
                                      size: 25,
                                      color: RawatinColorTheme.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, top: 20),
                                    child: Icon(
                                      FontAwesomeIcons.car,
                                      color: RawatinColorTheme.orange,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 170,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cuci di bengkel Rawat.in',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 14,
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Buat kamu yang nggak mau ribet. Terima pas udah bersih',
                                    style: TextStyle(
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp 25.000',
                              style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 18,
                                  color: RawatinColorTheme.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Rp 35.000',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: RawatinColorTheme.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
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
                          text: 'Dimana kami jemput?',
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CariAlamat(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: RawatinColorTheme.orange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Text('Ganti alamat',
                        style: RawatinColorTheme.secondaryTextTheme.titleSmall),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 275,
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
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: _initialCoordinate,
                                zoom: 17,
                              ),
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              markers: {
                                const Marker(
                                    markerId: MarkerId("demo"),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: _uibCoordinate),
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: RawatinColorTheme.black,
                                    fontFamily: 'Arial Rounded',
                                    fontSize: 18),
                                text: 'Universitas Internasional Batam',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.maxFinite,
                        height: 2,
                        child: const DecoratedBox(
                          decoration:
                              BoxDecoration(color: RawatinColorTheme.orange),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                        color: RawatinColorTheme.black,
                                        fontSize: 15),
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
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 15),
                                    text: 'Rp 8.000',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 210,
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
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  color: RawatinColorTheme.black,
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const SizedBox(
                              height: 10,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: double.maxFinite,
                        height: 2,
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: RawatinColorTheme.orange),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
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
                                        fontSize: 15),
                                    text: 'Cash',
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: const Row(
                                children: [
                                  Text('Ubah metode pembayaran',
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400)),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: RawatinColorTheme.black,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthRegister()),
                  );
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: RawatinColorTheme.orange,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Text('Buat Pesanan',
                    style: RawatinColorTheme.secondaryTextTheme.titleSmall),
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
