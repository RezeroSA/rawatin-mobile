import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rawatin/pages/buat_pesanan_darurat/index.dart';
import 'package:rawatin/pages/cari_alamat_emergency/index.dart';
import 'package:rawatin/pages/order_page/index.dart';
import 'package:rawatin/pages/payment_method/index.dart';
import 'package:rawatin/utils/utils.dart';
import 'dart:io';

class EmergencyOrder extends StatefulWidget {
  const EmergencyOrder({super.key});

  @override
  State<EmergencyOrder> createState() => _EmergencyOrderState();
}

class _EmergencyOrderState extends State<EmergencyOrder> {
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
                decoration: BoxDecoration(
                    color: RawatinColorTheme.red,
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
                                    image: AssetsLocation.imageLocation(
                                        'kecelakaan-putih'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            const SizedBox(
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
                                        color: RawatinColorTheme.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Kendaraan saya mengalami kecelakaan dan butuh pertolongan sekarang juga',
                                      style: TextStyle(
                                          color: RawatinColorTheme.white,
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
                                    image: AssetsLocation.imageLocation(
                                        'ban-bocor'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            const SizedBox(
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
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Ban saya bocor dan tidak ada bengkel terdekat. Tolong perbaiki ban saya',
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
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
                                    image: AssetsLocation.imageLocation(
                                        'mesin-mogok'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            const SizedBox(
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
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Kendaraan saya mati tiba-tiba dan tidak ada alat darurat untuk memperbaikinya',
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
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
                                    image: AssetsLocation.imageLocation(
                                        'tersesat'),
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                            const SizedBox(
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
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Saya tersesat dan tidak tahu kemana arah yang harus saya lalui',
                                      style: TextStyle(
                                          color: RawatinColorTheme.black,
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CariAlamatEmergency(),
                        ),
                      );
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
              Container(
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
                              BoxDecoration(color: RawatinColorTheme.red),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: RawatinColorTheme.black,
                                            fontSize: 14),
                                        text: 'Layanan Darurat - Kecelakaan',
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
                                        text: 'Rp 150.000',
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
                                        text: 'Rp 160.000',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentMethod()),
                                );
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
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
                        builder: (context) => const BuatPesananDarurat()),
                  );
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
