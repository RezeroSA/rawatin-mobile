import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rawatin/pages/buat_pesanan/index.dart';
import 'package:rawatin/pages/order_detail/canceled.dart';
import 'package:rawatin/pages/order_detail/index.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';

class OrderPageMain extends StatefulWidget {
  const OrderPageMain({super.key});

  @override
  State<OrderPageMain> createState() => _OrderPageMainState();
}

class _OrderPageMainState extends State<OrderPageMain>
    with TickerProviderStateMixin {
  OrderService _orderService = Get.put(OrderService());
  final box = GetStorage();

  dynamic orders;
  dynamic ordersCompleted;
  dynamic ordersCancelled;

  List orderList = [];

  Future<List> getWaitingInProcessOrder() async {
    var res =
        await _orderService.getWaitingOrders(userId: box.read('phoneNum'));

    setState(() {
      orderList = res.data['data']['orders'];
    });

    return [];
  }

  Future getCompletedOrder() async {
    ordersCompleted =
        await _orderService.getCompletedOrders(userId: box.read('phoneNum'));
    if (ordersCompleted.data['data']['orders'].length > 0) {
      return ordersCompleted.data['data']['orders'];
    } else {
      return null;
    }
  }

  Future getCancelledOrder() async {
    ordersCancelled =
        await _orderService.getCancelledOrders(userId: box.read('phoneNum'));
    if (ordersCancelled.data['data']['orders'].length > 0) {
      return ordersCancelled.data['data']['orders'];
    } else {
      return null;
    }
  }

  Future refresh() async {
    Future.delayed(const Duration(seconds: 1), () async {
      await getWaitingInProcessOrder();
    });
  }

  @override
  void initState() {
    super.initState();
    getWaitingInProcessOrder();
    getCancelledOrder();
    getCompletedOrder();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
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
                    children: [Expanded(child: buildOrder())],
                  ),
                  Column(
                    children: [Expanded(child: buildOrderCompleted())],
                  ),
                  Column(
                    children: [Expanded(child: buildOrderCancelled())],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOrder() {
    return RefreshIndicator(
      onRefresh: refresh,
      color: RawatinColorTheme.orange,
      child: orderList.length == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetsLocation.imageLocation('kosong'), width: 330),
                Text('Belum ada pesanan. Yuk buat pesanan!'),
              ],
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: ElevatedButton(
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
                                Text(
                                  order['service_name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: RawatinColorTheme.black,
                                      fontFamily: "Arial Rounded"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => BuatPesanan());
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
                                Column(
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
                                      order['officer'] != null
                                          ? order['officer']
                                          : 'Mencari petugas...',
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
                                Column(
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
                                      'Rp ${order['total']}',
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
                                                ..onTap = () => _cancel(
                                                    context, order['order_id']),
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
                  ],
                );
              },
            ),
    );
  }

  Widget buildOrderCompleted() {
    return FutureBuilder(
      future: getCompletedOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: RawatinColorTheme.white,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: RawatinColorTheme.white,
                          foregroundColor: RawatinColorTheme.white,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          fixedSize: const Size(double.maxFinite, 150),
                          side:
                              const BorderSide(color: RawatinColorTheme.orange),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data![index]['service_name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: RawatinColorTheme.black,
                                    fontFamily: "Arial Rounded"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => OrderDetail(
                                        orderId: snapshot.data![index]
                                            ['order_id'],
                                      ));
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => OrderDetail(
                                  //         orderId: snapshot.data![index]
                                  //             ['order_id']),
                                  //   ),
                                  // );
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
                              Column(
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
                                    snapshot.data![index]['officer'] != null
                                        ? snapshot.data![index]['officer']
                                        : 'Mencari petugas...',
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
                              Column(
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
                                    'Rp ${snapshot.data![index]['total']}',
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
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetsLocation.imageLocation('error'), width: 330),
              Text('Terjadi kesalahan saat memuat pesanan'),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetsLocation.imageLocation('kosong'), width: 330),
              Text('Belum ada pesanan. Yuk buat pesanan!'),
            ],
          );
        }
      },
    );
  }

  Widget buildOrderCancelled() {
    return FutureBuilder(
      future: getCancelledOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: RawatinColorTheme.white,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: RawatinColorTheme.white,
                          foregroundColor: RawatinColorTheme.white,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          fixedSize: const Size(double.maxFinite, 150),
                          side:
                              const BorderSide(color: RawatinColorTheme.orange),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data![index]['service_name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: RawatinColorTheme.black,
                                    fontFamily: "Arial Rounded"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => Canceled(
                                        orderId: snapshot.data![index]
                                            ['order_id'],
                                      ));
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => OrderDetail(
                                  //         orderId: snapshot.data![index]
                                  //             ['order_id']),
                                  //   ),
                                  // );
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
                              Column(
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
                                    snapshot.data![index]['officer'] != null
                                        ? snapshot.data![index]['officer']
                                        : '-',
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
                              Column(
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
                                    'Rp ${snapshot.data![index]['total']}',
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
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetsLocation.imageLocation('error'), width: 330),
              Text('Terjadi kesalahan saat memuat pesanan'),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetsLocation.imageLocation('kosong'), width: 330),
              Text('Belum ada pesanan. Yuk buat pesanan!'),
            ],
          );
        }
      },
    );
  }

  _cancel(context, id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController formAlasanController = TextEditingController();
          int type = 1;
          String alasanPembatalan = 'Petugas tidak merespon';
          return StatefulBuilder(
            builder: (context, setState) {
              void handleRadio(Object? e) => setState(() {
                    type = e as int;
                    if (e == 1) {
                      alasanPembatalan = 'Petugas tidak merespon';
                    } else if (e == 2) {
                      alasanPembatalan = 'Ingin mengubah layanan';
                    } else if (e == 3) {
                      alasanPembatalan = 'Ingin mengubah lokasi';
                    } else {
                      alasanPembatalan = formAlasanController.text;
                    }
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
                            GestureDetector(
                              onTap: () => handleRadio(1),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: size.width,
                                height: 55,
                                decoration: BoxDecoration(
                                  border: type == 1
                                      ? Border.all(
                                          width: 1,
                                          color: RawatinColorTheme.orange)
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
                                              activeColor:
                                                  RawatinColorTheme.orange,
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
                            ),
                            GestureDetector(
                              onTap: () => handleRadio(2),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: size.width,
                                height: 55,
                                decoration: BoxDecoration(
                                  border: type == 2
                                      ? Border.all(
                                          width: 1,
                                          color: RawatinColorTheme.orange)
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
                                              activeColor:
                                                  RawatinColorTheme.orange,
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
                            ),
                            GestureDetector(
                              onTap: () => handleRadio(3),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: size.width,
                                height: 55,
                                decoration: BoxDecoration(
                                  border: type == 3
                                      ? Border.all(
                                          width: 1,
                                          color: RawatinColorTheme.orange)
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
                                              activeColor:
                                                  RawatinColorTheme.orange,
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
                            ),
                            GestureDetector(
                              onTap: () => handleRadio(4),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: size.width,
                                height: 55,
                                decoration: BoxDecoration(
                                  border: type == 4
                                      ? Border.all(
                                          width: 1,
                                          color: RawatinColorTheme.orange)
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
                                              activeColor:
                                                  RawatinColorTheme.orange,
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
                            ),
                            TextFormField(
                              enabled: type == 4 ? true : false,
                              controller: formAlasanController,
                              onChanged: (value) {
                                setState(() {
                                  alasanPembatalan = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Alasan...',
                                labelStyle: const TextStyle(
                                    color: RawatinColorTheme.black),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: RawatinColorTheme.orange),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: type == 4
                                        ? const BorderSide(
                                            color: RawatinColorTheme.orange)
                                        : const BorderSide(
                                            color: RawatinColorTheme
                                                .secondaryGrey)),
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
                                var res = await _orderService.cancelOrder(
                                    orderId: id, reason: alasanPembatalan);
                                if (res == true) {
                                  Get.back();
                                  refresh();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.success,
                                          title: 'Berhasil',
                                          text: 'Pesanan berhasil dibatalin',
                                          confirmButtonText: 'OK',
                                          confirmButtonColor:
                                              RawatinColorTheme.orange));
                                } else {
                                  Get.back();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.danger,
                                          title: 'Error',
                                          text:
                                              'Terjadi kesalahan saat membatalkan pesanan',
                                          confirmButtonText: 'OK',
                                          confirmButtonColor:
                                              RawatinColorTheme.orange));
                                }
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
}
