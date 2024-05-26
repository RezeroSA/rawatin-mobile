import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService extends GetxController {
  final dio = Dio();

  Future<String?> searchLocation(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      // final response = await dio.get(uri.toString(), options: Options(headers: headers));

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}

// class NetworkUtility {
//   static Future<String?> fetchUrl(Uri uri,
//       {Map<String, String>? headers}) async {
//     try {
//       final response = await http.get(uri, headers: headers);
//       if (response.statusCode == 200) {
//         return response.body;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
// }
