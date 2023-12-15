import 'package:flutter/material.dart';
import 'package:rawatin/pages/emergency_order/index.dart';
import 'package:rawatin/utils/utils.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 35, 0, 10)),
              ),
              const Text(
                'Butuh bantuan darurat?',
                style: TextStyle(fontSize: 28, fontFamily: "Arial Rounded"),
              ),
              const Text(
                'Tekan tombol untuk minta bantuan',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => const EmergencyOrder(),
                    ),
                  );
                },
                icon: Image(
                  image: AssetsLocation.imageLocation('emergency'),
                ),
                splashColor: RawatinColorTheme.orange,
                highlightColor: RawatinColorTheme.red.withOpacity(0.1),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
              ),
              const Text(
                'Kapan saya bisa meminta bantuan darurat?',
                style: TextStyle(fontSize: 15, fontFamily: "Arial Rounded"),
              ),
              const Text(
                'Kamu bisa meminta bantuan darurat saat :',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      surfaceTintColor: Colors.white,
                      color: RawatinColorTheme.secondaryOrange,
                      child: SizedBox(
                        width: 88,
                        height: 74,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Kecelakaan',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Arial Rounded"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: AssetsLocation.imageLocation(
                                        'kecelakaan'),
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: RawatinColorTheme.secondaryOrange,
                      child: SizedBox(
                        width: 88,
                        height: 74,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Ban Bocor',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Arial Rounded"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: AssetsLocation.imageLocation(
                                        'ban-bocor'),
                                    height: 33,
                                    width: 33,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: RawatinColorTheme.secondaryOrange,
                      child: SizedBox(
                        width: 88,
                        height: 74,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Mesin Mogok',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Arial Rounded"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: AssetsLocation.imageLocation(
                                        'mesin-mogok'),
                                    height: 35,
                                    width: 35,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: RawatinColorTheme.secondaryOrange,
                      child: SizedBox(
                        width: 88,
                        height: 74,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Tersesat',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Arial Rounded"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: AssetsLocation.imageLocation(
                                        'tersesat'),
                                    height: 35,
                                    width: 35,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
