import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rawatin/pages/buat_pesanan/index.dart';
import 'package:rawatin/pages/cuci_mobil/index.dart';
import 'package:rawatin/pages/cuci_motor/index.dart';
import 'package:rawatin/pages/servis_mobil/index.dart';
import 'package:rawatin/pages/servis_motor/index.dart';
import 'package:rawatin/service/Authentication.dart';
import 'package:rawatin/service/order.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final numbers = List.generate(4, (index) => '$index');
  final box = GetStorage();
  final controller = ScrollController();
  final List<String> services = [
    'Cuci Mobil',
    'Servis Mobil',
    'Cuci Motor',
    'Servis Motor'
  ];
  final List<IconData> icons = [
    FontAwesomeIcons.car,
    FontAwesomeIcons.car,
    FontAwesomeIcons.motorcycle,
    FontAwesomeIcons.motorcycle,
  ];

  OrderService _orderService = Get.put(OrderService());
  AuthenticationService _authenticationService =
      Get.put(AuthenticationService());
  bool _isOrderExist = false;
  String orderType = '';

  Future<void> _getOrder() async {
    final res =
        await _orderService.getOrderByUser(userId: box.read('phoneNum'));

    if (res != null) {
      setState(() {
        _isOrderExist = true;
        orderType = res['order']['name'];
      });
    }
  }

  String name = '';
  String phone = '';
  String email = '';
  bool _isLoading = false;

  Future getProfile() async {
    setState(() {
      _isLoading = true;
    });
    final res =
        await _authenticationService.getProfile(phoneNum: box.read('phoneNum'));

    if (res != null) {
      setState(() {
        _isLoading = false;
        name = res['name'];
        phone = res['phone'];
        email = res['email'];
      });
    } else {
      setState(() {
        _isLoading = false;
        name = 'Gagal Mengambil Data';
        phone = '';
        email = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    _getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
              ),
              Skeletonizer(
                enabled: _isLoading,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: RawatinColorTheme.black, fontSize: 17),
                        text: 'Halo, 👋🏻 \n',
                      ),
                      TextSpan(
                        style: TextStyle(
                            color: RawatinColorTheme.orange,
                            fontFamily: 'Arial Rounded',
                            fontSize: 24),
                        text: name,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetsLocation.imageLocation('home'), width: 330),
                ],
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              ),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.892,
                    child: buildGridView(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() => GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 1.3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(4),
        controller: controller,
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          final item = numbers[index];
          final service = services[index];
          final icon = icons[index];

          return buildNumber(context, item, service, icon);
        },
      );

  Widget buildNumber(context, String number, String service, IconData icon) =>
      ElevatedButton(
        onPressed: () {
          if (_isOrderExist) {
            // print(orderType);
            if (orderType == 'Cuci Mobil - Cuci Dirumah' ||
                orderType == 'Cuci Mobil - Cuci Dibengkel') {
              if (service == 'Cuci Mobil') {
                Get.to(() => BuatPesanan());
              } else {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.warning,
                        title: 'Oops...',
                        text:
                            'Kamu tidak bisa membuat orderan baru karena memiliki orderan aktif atau dalam proses',
                        confirmButtonColor: RawatinColorTheme.orange));
              }
            } else if (orderType == 'Cuci Motor - Cuci Dirumah' ||
                orderType == 'Cuci Motor - Cuci Dibengkel') {
              if (service == 'Cuci Motor') {
                Get.to(() => BuatPesanan());
              } else {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.warning,
                        title: 'Oops...',
                        text:
                            'Kamu tidak bisa membuat orderan baru karena memiliki orderan aktif atau dalam proses',
                        confirmButtonColor: RawatinColorTheme.orange));
              }
            } else if (orderType == 'Servis Motor - Tune Up' ||
                orderType == 'Servis Motor - Servis Berkala' ||
                orderType == 'Servis Motor - Bodi dan Cat') {
              if (service == 'Servis Motor') {
                Get.to(() => BuatPesanan());
              } else {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.warning,
                        title: 'Oops...',
                        text:
                            'Kamu tidak bisa membuat orderan baru karena memiliki orderan aktif atau dalam proses',
                        confirmButtonColor: RawatinColorTheme.orange));
              }
            } else if (orderType == 'Servis Mobil - Tune Up' ||
                orderType == 'Servis Mobil - Servis Berkala' ||
                orderType == 'Servis Mobil - Bodi dan Cat') {
              if (service == 'Servis Mobil') {
                Get.to(() => BuatPesanan());
              } else {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.warning,
                        title: 'Oops...',
                        text:
                            'Kamu tidak bisa membuat orderan baru karena memiliki orderan aktif atau dalam proses',
                        confirmButtonColor: RawatinColorTheme.orange));
              }
            } else if (orderType.contains('Darurat')) {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: 'Oops...',
                      text:
                          'Kamu tidak bisa membuat orderan baru karena memiliki orderan darurat yang aktif atau dalam proses',
                      confirmButtonColor: RawatinColorTheme.orange));
            }
          } else {
            if (service == 'Cuci Mobil') {
              Get.to(() => CuciMobil());
            } else if (service == 'Cuci Motor') {
              Get.to(() => CuciMotor());
            } else if (service == 'Servis Motor') {
              Get.to(() => ServisMotor());
            } else if (service == 'Servis Mobil') {
              Get.to(() => ServisMobil());
            } else {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: 'Oops...',
                      text: 'Maaf, fitur ini sedang dalam pengembangan',
                      confirmButtonColor: RawatinColorTheme.orange));
            }
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: RawatinColorTheme.secondaryOrange,
            shadowColor: Colors.transparent,
            surfaceTintColor: RawatinColorTheme.white,
            foregroundColor: RawatinColorTheme.orange,
            splashFactory: NoSplash.splashFactory,
            // fixedSize: const Size(190, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 80,
              width: 80,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35, top: 20),
                    child: Icon(
                      icon,
                      size: 35,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: () {
                      if (service == 'Cuci Mobil' || service == 'Cuci Motor') {
                        return const Icon(
                          FontAwesomeIcons.shower,
                          size: 35,
                          color: RawatinColorTheme.black,
                        );
                      } else {
                        return const Icon(
                          FontAwesomeIcons.wrench,
                          color: RawatinColorTheme.black,
                          size: 35,
                        );
                      }
                    }(),
                  ),
                ],
              ),
            ),
            Text(
              service,
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Arial Rounded',
                  color: RawatinColorTheme.black),
            )
          ],
        ),
      );
}
