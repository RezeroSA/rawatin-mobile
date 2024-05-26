import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawatin/components/LocationListTile.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/models/autocomplete_prediction.dart';
import 'package:rawatin/models/place_autocomplete_response.dart';
import 'package:rawatin/pages/cari_alamat/peta.dart';
import 'package:rawatin/service/location.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:get/get.dart';

class CariAlamat extends StatefulWidget {
  const CariAlamat({super.key, required this.latLong});
  final LatLng latLong;

  @override
  State<CariAlamat> createState() => _CariAlamatState();
}

class _CariAlamatState extends State<CariAlamat> {
  List<AutocompletePrediction> placePredictions = [];
  // List<dynamic> _placePredictions = [];

  final dio = Dio();
  final LocationService _locationService = Get.put(LocationService());
  // LatLng _latLong = LatLng(0, 0);

  void placeAutocomplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com",
        'maps/api/place/autocomplete/json', {"input": query, "key": apiKey});

    String? response = await _locationService.searchLocation(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
          // print(response);
        });
      }
    }
  }

  Future<LatLng?> getPlaceLatLng(String placeId) async {
    var uri =
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey';

    try {
      var response = await Dio().get(uri);

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        var lat = response.data['results'][0]['geometry']['location']['lat'];
        var lng = response.data['results'][0]['geometry']['location']['lng'];
        return LatLng(lat, lng);
      } else {
        return null;
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      print('Error fetching place details: $e');
      return null;
    }
  }

  Future<LatLng> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: RawatinColorTheme.white,
          backgroundColor: RawatinColorTheme.white,
          title: const Text(
            'Cari Alamat',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Arial Rounded',
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(FontAwesomeIcons.locationArrow),
                onPressed: () async {
                  await _getLocation().then((value) {
                    Get.back(result: value);
                  });
                })
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            ),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: TextFormField(
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: RawatinColorTheme.orange,
                  ),
                  labelText: 'Cari lokasi',
                  labelStyle: TextStyle(color: RawatinColorTheme.orange),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: RawatinColorTheme.orange),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: RawatinColorTheme.orange),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: RawatinColorTheme.orange),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                        text: 'Pilih Lokasi',
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => Peta(
                          latLong: widget.latLong,
                        ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: RawatinColorTheme.orange,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        FontAwesomeIcons.mapLocationDot,
                        color: RawatinColorTheme.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Pilih lewat peta',
                          style:
                              RawatinColorTheme.secondaryTextTheme.titleSmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: placePredictions.length,
                itemBuilder: (context, index) => LocationListTile(
                  name: placePredictions[index].description!,
                  press: () async {
                    () async {
                      getPlaceLatLng(placePredictions[index].placeId!)
                          .then((value) => Get.back(result: value));
                    }();
                    // .then((value) => print(value));
                    // .then((value) => Get.back(result: _latLong));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
