import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rawatin/pages/order_detail/index.dart';
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (_) => const OrderDetail(),
                                      ),
                                    );
                                  },
                                  child: const SizedBox(
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
                                                ..onTap =
                                                    () => _cancel(context),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (_) => const OrderDetail(),
                                      ),
                                    );
                                  },
                                  child: const SizedBox(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cuci Mobil',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (_) => const OrderDetail(),
                                      ),
                                    );
                                  },
                                  child: const SizedBox(
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

_cancel(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        int type = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            void handleRadio(Object? e) => setState(() {
                  type = e as int;
                });
            Size size = MediaQuery.of(context).size;

            return Dialog(
              surfaceTintColor: RawatinColorTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 480),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                          ),
                          const Text(
                            'Alasan Pembatalan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Arial Rounded',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              border: type == 1
                                  ? Border.all(
                                      width: 1, color: RawatinColorTheme.orange)
                                  : Border.all(
                                      width: 0.3,
                                      color: RawatinColorTheme.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 1,
                                          groupValue: type,
                                          onChanged: handleRadio,
                                          activeColor: RawatinColorTheme.orange,
                                        ),
                                        const Text(
                                          "Petugas tidak merespon",
                                          style: TextStyle(
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              border: type == 2
                                  ? Border.all(
                                      width: 1, color: RawatinColorTheme.orange)
                                  : Border.all(
                                      width: 0.3,
                                      color: RawatinColorTheme.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 2,
                                          groupValue: type,
                                          onChanged: handleRadio,
                                          activeColor: RawatinColorTheme.orange,
                                        ),
                                        const Text(
                                          "Ingin mengubah layanan",
                                          style: TextStyle(
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              border: type == 3
                                  ? Border.all(
                                      width: 1, color: RawatinColorTheme.orange)
                                  : Border.all(
                                      width: 0.3,
                                      color: RawatinColorTheme.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 3,
                                          groupValue: type,
                                          onChanged: handleRadio,
                                          activeColor: RawatinColorTheme.orange,
                                        ),
                                        const Text(
                                          "Ingin mengubah lokasi",
                                          style: TextStyle(
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              border: type == 4
                                  ? Border.all(
                                      width: 1, color: RawatinColorTheme.orange)
                                  : Border.all(
                                      width: 0.3,
                                      color: RawatinColorTheme.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 4,
                                          groupValue: type,
                                          onChanged: handleRadio,
                                          activeColor: RawatinColorTheme.orange,
                                        ),
                                        const Text(
                                          "Alasan Lain",
                                          style: TextStyle(
                                            fontFamily: 'Arial Rounded',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            enabled: type == 4 ? true : false,
                            decoration: InputDecoration(
                              labelText: 'Alasan...',
                              labelStyle: const TextStyle(
                                  color: RawatinColorTheme.black),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: RawatinColorTheme.orange),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: type == 4
                                      ? const BorderSide(
                                          color: RawatinColorTheme.orange)
                                      : const BorderSide(
                                          color:
                                              RawatinColorTheme.secondaryGrey)),
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: RawatinColorTheme.secondaryGrey),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(10))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: RawatinColorTheme.orange),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: RawatinColorTheme.orange,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: RawatinColorTheme.orange),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            child: const Text('Batalkan pesanan',
                                style: TextStyle(
                                    fontFamily: 'Arial Rounded',
                                    fontSize: 15,
                                    color: RawatinColorTheme.white)),
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
