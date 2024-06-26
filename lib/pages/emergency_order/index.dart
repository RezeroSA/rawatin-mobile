import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/buat_pesanan_darurat/index.dart';
import 'package:rawatin/pages/cari_alamat/index.dart';
import 'package:rawatin/pages/cari_alamat_emergency/index.dart';
import 'package:rawatin/pages/payment_method/index.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';
import 'dart:io';

import 'package:skeletonizer/skeletonizer.dart';

class EmergencyOrder extends StatefulWidget {
  const EmergencyOrder({super.key});

  @override
  State<EmergencyOrder> createState() => _EmergencyOrderState();
}

class _EmergencyOrderState extends State<EmergencyOrder> {
  String services = 'Bantuan Darurat';
  String tipeLayanan = 'Kecelakaan';
  bool isKecelakaan = true;
  bool isBanBocor = false;
  bool isMesinMogok = false;
  bool isTersesat = false;
  bool _isLoading = false;
  String location = '';
  double tarifLayanan = 100000;
  double tarif = 0;
  double total = 0;
  String metodePembayaran = '';
  LatLng _latLong = LatLng(0, 0);
  GoogleMapController? _mapController;
  final dio = Dio();

  static const LatLng _initialCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);
  static const LatLng _uibCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);

  XFile? image;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
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
  void initState() {
    super.initState();
    _getLocation().then((value) => _getLocationCoordinate()
        .then((value) => _countDistance(value))
        .then((value) => _hitungTotal()));
  }

  final OrderService _orderService = Get.put(OrderService());

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: RawatinColorTheme.white,
            surfaceTintColor: RawatinColorTheme.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text(
              'Pilih media yang akan dipilih',
              style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 20),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RawatinColorTheme.white,
                      surfaceTintColor: RawatinColorTheme.white,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: RawatinColorTheme.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dari Galeri',
                          style: TextStyle(color: RawatinColorTheme.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RawatinColorTheme.white,
                      surfaceTintColor: RawatinColorTheme.white,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: RawatinColorTheme.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dari Kamera',
                          style: TextStyle(color: RawatinColorTheme.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String phoneNum = box.read('phoneNum') ?? '';
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
          'Bantuan Darurat',
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
                          text: 'Bukti keadaan darurat',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              image != null
                  ? GestureDetector(
                      onTap: () {
                        myAlert();
                      },
                      child: DottedBorder(
                        color: RawatinColorTheme.red,
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        dashPattern: const [8, 4],
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            height: 250,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: RawatinColorTheme.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(width: 1, color: RawatinColorTheme.red),
                            ),
                            child: Image.file(
                              //to show image, you type like this.
                              File(image!.path),
                              fit: BoxFit.fitHeight,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        myAlert();
                      },
                      child: DottedBorder(
                        color: RawatinColorTheme.red,
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        dashPattern: const [8, 4],
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            height: 250,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: RawatinColorTheme.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(width: 1, color: RawatinColorTheme.red),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.plus,
                                    color: RawatinColorTheme.red,
                                  ),
                                  Text(
                                    'Tambah bukti',
                                    style:
                                        TextStyle(color: RawatinColorTheme.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      style: TextStyle(
                        color: RawatinColorTheme.black,
                        fontSize: 10,
                      ),
                      text:
                          'Kami membutuhkan bukti bahwa keadaan darurat benar terjadi agar tidak terjadi order fiktif. ',
                    ),
                    TextSpan(
                        style: const TextStyle(
                            color: RawatinColorTheme.red, fontSize: 10),
                        text: 'Pelajari hal ini...',
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      style: TextStyle(
                          color: RawatinColorTheme.black,
                          fontFamily: 'Arial Rounded',
                          fontSize: 15),
                      text: 'Bantuan darurat apa yang kamu butuhkan?',
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
                decoration: isKecelakaan
                    ? BoxDecoration(
                        color: RawatinColorTheme.red,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10)),
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
                      tarifLayanan = 100000;
                      tipeLayanan = 'Kecelakaan';
                      isKecelakaan = true;
                      isBanBocor = false;
                      isMesinMogok = false;
                      isTersesat = false;
                    });
                    _hitungTotal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image(
                                    image: isKecelakaan
                                        ? AssetsLocation.imageLocation(
                                            'kecelakaan-putih')
                                        : AssetsLocation.imageLocation(
                                            'kecelakaan'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            SizedBox(
                              width: 260,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kecelakaan',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 16,
                                        color: isKecelakaan
                                            ? RawatinColorTheme.white
                                            : RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Kendaraan saya mengalami kecelakaan dan butuh pertolongan sekarang juga',
                                      style: TextStyle(
                                          color: isKecelakaan
                                              ? RawatinColorTheme.white
                                              : RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
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
              const SizedBox(
                height: 2.5,
              ),
              Container(
                height: 80,
                width: double.maxFinite,
                decoration: isBanBocor
                    ? BoxDecoration(
                        color: RawatinColorTheme.red,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10)),
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
                      tipeLayanan = 'Ban Bocor';
                      tarifLayanan = 125000;
                      isKecelakaan = false;
                      isBanBocor = true;
                      isMesinMogok = false;
                      isTersesat = false;
                    });
                    _hitungTotal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image(
                                    image: isBanBocor
                                        ? AssetsLocation.imageLocation(
                                            'ban-bocor-putih')
                                        : AssetsLocation.imageLocation(
                                            'ban-bocor'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            SizedBox(
                              width: 260,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ban Bocor',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 16,
                                        color: isBanBocor
                                            ? RawatinColorTheme.white
                                            : RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Ban saya bocor dan tidak ada bengkel terdekat. Tolong perbaiki ban saya',
                                      style: TextStyle(
                                          color: isBanBocor
                                              ? RawatinColorTheme.white
                                              : RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
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
              const SizedBox(
                height: 2.5,
              ),
              Container(
                height: 80,
                width: double.maxFinite,
                decoration: isMesinMogok
                    ? BoxDecoration(
                        color: RawatinColorTheme.red,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10)),
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
                      tipeLayanan = 'Mesin Mogok';
                      tarifLayanan = 200000;
                      isKecelakaan = false;
                      isBanBocor = false;
                      isMesinMogok = true;
                      isTersesat = false;
                    });
                    _hitungTotal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image(
                                    image: isMesinMogok
                                        ? AssetsLocation.imageLocation(
                                            'mesin-mogok-putih')
                                        : AssetsLocation.imageLocation(
                                            'mesin-mogok'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            SizedBox(
                              width: 260,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mesin Mogok',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 16,
                                        color: isMesinMogok
                                            ? RawatinColorTheme.white
                                            : RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Kendaraan saya mati tiba-tiba dan tidak ada alat darurat untuk memperbaikinya',
                                      style: TextStyle(
                                          color: isMesinMogok
                                              ? RawatinColorTheme.white
                                              : RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
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
              const SizedBox(
                height: 2.5,
              ),
              Container(
                height: 80,
                width: double.maxFinite,
                decoration: isTersesat
                    ? BoxDecoration(
                        color: RawatinColorTheme.red,
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: RawatinColorTheme.white,
                        borderRadius: BorderRadius.circular(10)),
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
                      tipeLayanan = 'Tersesat';
                      tarifLayanan = 50000;
                      isKecelakaan = false;
                      isBanBocor = false;
                      isMesinMogok = false;
                      isTersesat = true;
                    });
                    _hitungTotal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image(
                                    image: isTersesat
                                        ? AssetsLocation.imageLocation(
                                            'tersesat-putih')
                                        : AssetsLocation.imageLocation(
                                            'tersesat'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            SizedBox(
                              width: 260,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tersesat',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 16,
                                        color: isTersesat
                                            ? RawatinColorTheme.white
                                            : RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Saya tersesat dan tidak tahu kemana arah yang harus saya lalui',
                                      style: TextStyle(
                                          color: isTersesat
                                              ? RawatinColorTheme.white
                                              : RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
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
                          text: 'Dimana lokasi kamu?',
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
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
                      backgroundColor: RawatinColorTheme.red,
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
                    color: RawatinColorTheme.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: RawatinColorTheme.red),
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
                              decoration:
                                  BoxDecoration(color: RawatinColorTheme.red),
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
              const SizedBox(
                height: 15,
              ),
              Skeletonizer(
                enabled: _isLoading,
                child: Container(
                  height: 210,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: RawatinColorTheme.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: RawatinColorTheme.red),
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
                                              'Bantuan Darurat - ${tipeLayanan}',
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
                                BoxDecoration(color: RawatinColorTheme.red),
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
                  if (image == null) {
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.warning,
                            title: "Oops...",
                            text: "Kamu belum menambahkan bukti foto",
                            confirmButtonText: "Oke",
                            confirmButtonColor: RawatinColorTheme.red));
                  } else if (metodePembayaran == '') {
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.warning,
                            title: 'Oops...',
                            text: 'Kamu belum memilih metode pembayaran',
                            confirmButtonColor: RawatinColorTheme.red));
                  } else {
                    () async {
                      await _orderService.insertEmergencyOrder(
                          userId: phoneNum,
                          serviceId: tipeLayanan == 'Kecelakaan'
                              ? 11
                              : tipeLayanan == 'Ban Bocor'
                                  ? 12
                                  : tipeLayanan == 'Mesin Mogok'
                                      ? 13
                                      : 14,
                          service_fee: tarifLayanan,
                          transport_fee: tarif,
                          total: total,
                          payment_method: metodePembayaran,
                          latitude: _latLong.latitude,
                          longitude: _latLong.longitude,
                          image: image);
                    }();
                  }
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: RawatinColorTheme.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Text('Kirim Layanan Darurat',
                    style: RawatinColorTheme.secondaryTextTheme.titleSmall),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
