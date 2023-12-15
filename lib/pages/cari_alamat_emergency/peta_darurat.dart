import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/utils/utils.dart';

class PetaDarurat extends StatefulWidget {
  const PetaDarurat({super.key});

  @override
  State<PetaDarurat> createState() => _PetaDaruratState();
}

class _PetaDaruratState extends State<PetaDarurat> {
  static const LatLng _initialCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);
  static const LatLng _uibCoordinate =
      LatLng(1.119566826789065, 104.00304630763641);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 5, blurStyle: BlurStyle.normal),
                ],
              ),
              child: IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                icon: const Icon(Icons
                    .arrow_back_ios_new_sharp), // Put icon of your preference.
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.8,
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
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 5, blurStyle: BlurStyle.normal),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: RawatinColorTheme.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55,
                              child: Icon(
                                FontAwesomeIcons.mapLocationDot,
                                color: RawatinColorTheme.black,
                                size: 25,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Universitas Internasional Batam',
                                    style: TextStyle(
                                        fontFamily: 'Arial Rounded',
                                        fontSize: 14,
                                        color: RawatinColorTheme.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Baloi-Sei Ladi, Jl. Gajah Mada, Tiban Indah, Kec...',
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 20),
                      backgroundColor: RawatinColorTheme.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Text('Lanjut',
                        style: RawatinColorTheme.secondaryTextTheme.titleSmall),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
