import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Peta extends StatefulWidget {
  const Peta({super.key, required this.latLong});
  final LatLng latLong;

  @override
  State<Peta> createState() => _PetaState();
}

class _PetaState extends State<Peta> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng _latLong = LatLng(0, 0);
  String locationName = '';
  String locationDetail = '';
  bool _isLoading = false;

  void initState() {
    super.initState();
    _onMapTapped(widget.latLong);
    _getLocation(widget.latLong);
  }

  Future<void> _onMapTapped(LatLng position) async {
    setState(() {
      _latLong = position;
      _isLoading = true;
      // Perbarui daftar marker dengan marker baru di posisi yang ditekan
      _markers = {
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      };
    });
  }

  Future<void> _getLocation(position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _latLong = LatLng(position.latitude, position.longitude);
        locationName = placemarks[0].name!;
        locationDetail = placemarks[0].name! +
            ', ' +
            placemarks[0].subLocality! +
            ', ' +
            placemarks[0].locality! +
            ', ' +
            placemarks[0].administrativeArea!;
      });
    });
  }

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
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: widget.latLong,
                zoom: 17,
              ),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              indoorViewEnabled: true,
              buildingsEnabled: true,
              onTap: (argument) async {
                () async {
                  _onMapTapped(argument)
                      .then((value) => _getLocation(argument));
                }();
              },
              markers: _markers,
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
                  Skeletonizer(
                    enabled: _isLoading,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: RawatinColorTheme.secondaryOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
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
                                      // 'Universitas Internasional Batam',
                                      locationName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Arial Rounded',
                                          fontSize: 14,
                                          color: RawatinColorTheme.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      // 'Baloi-Sei Ladi, Jl. Gajah Mada, Tiban Indah, Kec...',
                                      locationDetail,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.back(result: _latLong);
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 20),
                      backgroundColor: RawatinColorTheme.orange,
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
