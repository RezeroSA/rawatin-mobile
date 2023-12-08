import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rawatin/utils/utils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final numbers = List.generate(4, (index) => '$index');
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

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      // body: Container(
      //   child: buildGridView(),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
              ),
              RichText(
                text: const TextSpan(
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
                      text: 'User',
                    ),
                  ],
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

          return buildNumber(item, service, icon);
        },
      );

  Widget buildNumber(String number, String service, IconData icon) =>
      ElevatedButton(
        onPressed: () {},
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
              // 'Cuci Mobil',
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Arial Rounded',
                  color: RawatinColorTheme.black),
            )
          ],
        ),
      );
}
