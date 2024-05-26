import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/cari_alamat/index.dart';
import 'package:rawatin/pages/payment_method/index.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CuciMotor extends StatefulWidget {
  const CuciMotor({super.key});

  @override
  State<CuciMotor> createState() => _CuciMotorState();
}

class _CuciMotorState extends State<CuciMotor> {
  String service = 'Cuci Motor';
  String tipeLayanan = 'Cuci dirumah';
  bool isCuciDirumah = true;
  bool isCuciDiBengkel = false;
  double tarifLayanan = 7500;
  double tarif = 0;
  double total = 0;
  String metodePembayaran = '';

  bool _isLoading = true;
  LatLng _latLong = LatLng(0, 0);
  String location = '';
  GoogleMapController? _mapController;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    _getLocation().then((value) => _getLocationCoordinate()
        .then((value) => _countDistance(value))
        .then((value) => _hitungTotal()));
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
        _latLong = LatLng(position.latitude, position.longitude);
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

  Future<LatLng> _getLocationCoordinate() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _latLong = LatLng(position.latitude, position.longitude);
    });

    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _latLong = LatLng(position.latitude, position.longitude);
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

  void _updateCameraPosition(LatLng _newCenter) {
    // Buat objek CameraPosition baru dengan koordinat yang baru
    CameraPosition newPosition = CameraPosition(
      target: _newCenter,
      zoom: 17.0,
    );

    // Lakukan animasi perpindahan kamera ke posisi baru
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  void _countDistance(LatLng latlong) async {
    setState(() {
      _isLoading = true;
    });
    var uri =
        "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${latlong.latitude}%2C${latlong.longitude}&origins=1.1195431%2C104.0030429&key=${apiKey}";

    try {
      var response = await Dio().get(uri);

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        double jarakKilometer =
            response.data['rows'][0]['elements'][0]['distance']['value'] / 1000;

        double tarifPerKilometer = 1500; // 1500 rupiah
        double biaya = jarakKilometer * tarifPerKilometer;

        setState(() {
          _isLoading = false;
          tarif = biaya;
        });
      } else {
        return null;
      }
    } catch (e) {}
  }

  void _hitungTotal() {
    double totals = tarif + tarifLayanan + 2000.toDouble();
    setState(() {
      total = totals;
    });
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: tarif,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));

    MoneyFormatter formattedTarifLayanan = MoneyFormatter(
        amount: tarifLayanan,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    MoneyFormatter formattedTotal = MoneyFormatter(
        amount: total,
        settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Cuci Motor',
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
                decoration: isCuciDirumah
                    ? BoxDecoration(
                        color: RawatinColorTheme.secondaryOrange,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    // Navigator.of(context, rootNavigator: true).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => const OrderPageMain(),
                    //   ),
                    // );
                    setState(() {
                      tipeLayanan = 'Cuci dirumah';
                      tarifLayanan = 7500;
                      isCuciDirumah = true;
                      isCuciDiBengkel = false;
                    });
                    _hitungTotal();
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
                                      FontAwesomeIcons.motorcycle,
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
                              'Rp 7.500',
                              style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 18,
                                  color: RawatinColorTheme.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Rp 15.000',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: RawatinColorTheme.red,
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
                decoration: isCuciDiBengkel
                    ? BoxDecoration(
                        color: RawatinColorTheme.secondaryOrange,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    // Navigator.of(context, rootNavigator: true).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => const OrderPageMain(),
                    //   ),
                    // );
                    setState(() {
                      tipeLayanan = 'Cuci di bengkel';
                      tarifLayanan = 15000;
                      isCuciDirumah = false;
                      isCuciDiBengkel = true;
                    });
                    _hitungTotal();
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
                                      FontAwesomeIcons.motorcycle,
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
                                  color: RawatinColorTheme.red,
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
                    onPressed: () async {
                      // setState(() {
                      //   _isLoading = !_isLoading;
                      // });
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => const CariAlamat(),
                      //   ),
                      // );
                      await Get.to(() => CariAlamat(
                            latLong: _latLong,
                          ))?.then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  _latLong = value;
                                }),
                                () async {
                                  _updateCameraPosition(_latLong);
                                  _getLocationUpdate(_latLong);
                                }()
                                    .then((value) => _countDistance(_latLong))
                                    .then((value) => _hitungTotal())
                              }
                          });
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
              Skeletonizer(
                enabled: _isLoading,
                child: Container(
                  height: 275,
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
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AbsorbPointer(
                              absorbing: true,
                              child: _isLoading
                                  ? Skeleton.leaf(
                                      child: Card(
                                        color: RawatinColorTheme.grey,
                                      ),
                                    )
                                  : GoogleMap(
                                      onMapCreated: (controller) {
                                        _mapController = controller;
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: _latLong,
                                        zoom: 18,
                                      ),
                                      myLocationButtonEnabled: false,
                                      zoomControlsEnabled: false,
                                      markers: {
                                        Marker(
                                            markerId: MarkerId("demo"),
                                            icon:
                                                BitmapDescriptor.defaultMarker,
                                            position: _latLong),
                                      },
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                      color: RawatinColorTheme.black,
                                      fontFamily: 'Arial Rounded',
                                      fontSize: 15),
                                  text: _isLoading
                                      ? 'This text is still loading, you cant see this because wrapped in skeleton hahahahahah...'
                                      : '${location}',
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Skeleton.keep(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: double.maxFinite,
                            height: 2,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                  color: RawatinColorTheme.orange),
                            ),
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
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded',
                                          fontSize: 15),
                                      text:
                                          'Rp ${fmf.output.withoutFractionDigits}',
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
              ),
              /////////
              ///
              ///
              ///
              ///
              ///
              ///
              ///
              ///
              ///
              // Container(
              //   height: 275,
              //   width: double.maxFinite,
              //   decoration: BoxDecoration(
              //     color: RawatinColorTheme.secondaryOrange,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(width: 1, color: RawatinColorTheme.orange),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         SizedBox(
              //           width: double.maxFinite,
              //           height: 170,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(10),
              //             child: AbsorbPointer(
              //               absorbing: true,
              //               child: _isLoading
              //                   ? Skeletonizer(
              //                       enabled: _isLoading,
              //                       child: ListView.builder(
              //                         itemCount: 7,
              //                         itemBuilder: (context, index) {
              //                           return Card(
              //                             child: ListTile(
              //                               title: Text(
              //                                   'Item number $index as title'),
              //                               subtitle:
              //                                   const Text('Subtitle here'),
              //                               trailing: const Icon(Icons.ac_unit),
              //                             ),
              //                           );
              //                         },
              //                       ),
              //                     )
              //                   : GoogleMap(
              //                       initialCameraPosition: CameraPosition(
              //                         target: _latLong,
              //                         zoom: 17,
              //                       ),
              //                       myLocationButtonEnabled: false,
              //                       zoomControlsEnabled: false,
              //                       markers: {
              //                         Marker(
              //                             markerId: MarkerId("demo"),
              //                             icon: BitmapDescriptor.defaultMarker,
              //                             position: _latLong),
              //                       },
              //                     ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(top: 10),
              //           child: RichText(
              //             text: const TextSpan(
              //               children: [
              //                 TextSpan(
              //                   style: TextStyle(
              //                       color: RawatinColorTheme.black,
              //                       fontFamily: 'Arial Rounded',
              //                       fontSize: 18),
              //                   text: 'Universitas Internasional Batam',
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(top: 10),
              //           width: double.maxFinite,
              //           height: 2,
              //           child: const DecoratedBox(
              //             decoration:
              //                 BoxDecoration(color: RawatinColorTheme.orange),
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(top: 10),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               RichText(
              //                 text: const TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       style: TextStyle(
              //                           color: RawatinColorTheme.black,
              //                           fontSize: 15),
              //                       text: 'Biaya transport petugas',
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               RichText(
              //                 text: const TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       style: TextStyle(
              //                           color: RawatinColorTheme.black,
              //                           fontFamily: 'Arial Rounded',
              //                           fontSize: 15),
              //                       text: 'Rp 8.000',
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Skeletonizer(
                enabled: _isLoading,
                child: Container(
                  height: 210,
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
                                          text:
                                              'Layanan Cuci Motor - ${tipeLayanan}',
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
                                              'Rp ${formattedTarifLayanan.output.withoutFractionDigits}',
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
                                              'Rp ${fmf.output.withoutFractionDigits}',
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
                              const SizedBox(
                                height: 10,
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
                                              'Rp ${formattedTotal.output.withoutFractionDigits}',
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
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded',
                                          fontSize: 15),
                                      text: metodePembayaran != ''
                                          ? metodePembayaran
                                          : 'Metode pembayaran',
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Get.to(() => PaymentMethod())
                                      ?.then((value) => {
                                            if (value != null)
                                              {
                                                setState(() {
                                                  metodePembayaran = value;
                                                })
                                              }
                                          });
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                child: Row(
                                  children: [
                                    metodePembayaran == ''
                                        ? Text('Ubah metode pembayaran',
                                            style: TextStyle(
                                                color: RawatinColorTheme.black,
                                                fontWeight: FontWeight.w400))
                                        : Text(''),
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  print('Jenis Layanan : ${service}');
                  print('Tipe Layanan : ${tipeLayanan}');
                  print('Transport Petugas : ${tarif}');
                  print('Tarif Layanan : ${tarifLayanan}');
                  print('Total : ${total}');
                  print('Metode Pembayaran : ${metodePembayaran}');
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
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
