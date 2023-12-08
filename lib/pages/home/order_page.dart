import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
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
                    text: 'Pesanan saya',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TabBar(
              controller: tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.all(3),
              labelStyle: const TextStyle(
                fontFamily: 'Arial Rounded',
                fontSize: 13,
              ),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: RawatinColorTheme.orange.withOpacity(0.9)),
              tabs: const [
                SizedBox(
                  height: 30,
                  width: 120,
                  // color: Colors.red,
                  child: Tab(
                    child: Text(
                      'Sedang Berjalan',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 120,
                  // color: Colors.red,
                  child: Tab(
                    child: Text(
                      'Selesai',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 120,
                  // color: Colors.red,
                  child: Tab(
                    child: Text(
                      'Dibatalkan',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: RawatinColorTheme.white,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: RawatinColorTheme.white,
                            foregroundColor: RawatinColorTheme.white,
                            splashFactory: NoSplash.splashFactory,
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            fixedSize: const Size(double.maxFinite, 150),
                            side: const BorderSide(
                                color: RawatinColorTheme.orange),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Detail',
                                        style: TextStyle(
                                            color: RawatinColorTheme.orange,
                                            fontFamily: 'Arial Rounded'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Petugas',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Sandy Alferro',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2,
                                  height: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: RawatinColorTheme.grey
                                            .withOpacity(0.7)),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Rp 148.000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              style: const TextStyle(
                                                  color: RawatinColorTheme.red,
                                                  fontFamily: 'Arial Rounded'),
                                              text: 'Cancel',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    _autentikasiBiometrik(
                                                        context),
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
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: RawatinColorTheme.white,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: RawatinColorTheme.white,
                            foregroundColor: RawatinColorTheme.white,
                            splashFactory: NoSplash.splashFactory,
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            fixedSize: const Size(double.maxFinite, 150),
                            side: const BorderSide(
                                color: RawatinColorTheme.orange),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Detail',
                                        style: TextStyle(
                                            color: RawatinColorTheme.orange,
                                            fontFamily: 'Arial Rounded'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Petugas',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Sandy Alferro',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2,
                                  height: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: RawatinColorTheme.grey
                                            .withOpacity(0.7)),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Rp 148.000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
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
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: RawatinColorTheme.white,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: RawatinColorTheme.white,
                            foregroundColor: RawatinColorTheme.white,
                            splashFactory: NoSplash.splashFactory,
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            fixedSize: const Size(double.maxFinite, 150),
                            side: const BorderSide(
                                color: RawatinColorTheme.orange),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Detail',
                                        style: TextStyle(
                                            color: RawatinColorTheme.orange,
                                            fontFamily: 'Arial Rounded'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Petugas',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Sandy Alferro',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2,
                                  height: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: RawatinColorTheme.grey
                                            .withOpacity(0.7)),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: RawatinColorTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      'Rp 148.000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: RawatinColorTheme.black,
                                          fontFamily: 'Arial Rounded'),
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
            )
          ],
        ),
      ),
    );
  }
}

_autentikasiBiometrik(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int? selectedValue = 1;
            // bool authenticated = false;
            return Dialog(
              surfaceTintColor: RawatinColorTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 550),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      ),
                      const Text(
                        'Alasan pembatalan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Arial Rounded',
                        ),
                      ),
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      ),
                      const Text(
                        'Petugas kami juga manusia yang bekerja untuk mencari rezeki, sehingga kami meminimalisir kemungkinan order fiktif terjadi. Masukkan alasan kamu membatalkan order.',
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          RadioListTile<int>(
                            value: 1,
                            title: const Text('Driver tidak merespon'),
                            groupValue: selectedValue,
                            onChanged: (value) =>
                                setState(() => selectedValue = value),
                          ),
                          RadioListTile<int>(
                            value: 2,
                            title: const Text('Ingin mengganti lokasi'),
                            groupValue: selectedValue,
                            onChanged: (value) =>
                                setState(() => selectedValue = value),
                          ),
                          RadioListTile<int>(
                            value: 3,
                            title: const Text('Ingin mengganti layanan'),
                            groupValue: selectedValue,
                            onChanged: (value) =>
                                setState(() => selectedValue = value),
                          ),
                          RadioListTile<int>(
                            value: 4,
                            title: const Text('Lainnya'),
                            groupValue: selectedValue,
                            onChanged: (value) =>
                                setState(() => selectedValue = value),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {},
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: Text('Batalkan',
                            style: RawatinColorTheme
                                .secondaryTextTheme.titleSmall),
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
