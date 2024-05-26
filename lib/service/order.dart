import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rawatin/pages/buat_pesanan/index.dart';
import 'package:rawatin/utils/utils.dart';
import 'dart:convert';

class OrderService extends GetxController {
  final isLoading = false.obs;
  final isResend = false.obs;
  final dio = Dio();
  final box = GetStorage();

  Future insertOrder({
    required String userId,
    required int serviceId,
    required double service_fee,
    required double transport_fee,
    required double total,
    required String payment_method,
    required double latitude,
    required double longitude,
  }) async {
    var data = {
      'user_id': userId,
      'service_id': serviceId,
      'service_fee': service_fee,
      'transport_fee': transport_fee,
      'total': total,
      'payment_method': payment_method,
      'latitude': latitude,
      'longitude': longitude,
      'status': "waiting",
    };

    try {
      var response = await dio.post(url + 'insertOrder',
          data: data,
          options: Options(
              followRedirects: false, validateStatus: (status) => true));

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          Future.delayed(const Duration(seconds: 1), () {
            ArtSweetAlert.show(
                context: Get.context!,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.success,
                  title: 'Berhasil',
                  text: 'Pesanan berhasil dibuat',
                ));
          }).then((value) => Get.off(() => const BuatPesanan()));
        }
      }
    } catch (e) {
      print(e);
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Gagal',
              text:
                  'Terjadi kesalahan saat membuat pesanan, silahkan coba beberapa saat lagi...',
              confirmButtonText: 'OK',
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future getOrderByUser({
    required String userId,
  }) async {
    var data = {
      'user_id': userId,
    };
    try {
      var response = await dio.post(url + 'getUserOrder', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return response.data['data'];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: userId);
              },
              onDispose: () async {
                await getOrderByUser(userId: userId);
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future getWaitingOrders({
    required String userId,
  }) async {
    var data = {
      'user_id': userId,
    };
    try {
      var response = await dio.post(url + 'getWaitingOrders', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // print(json.encode(json.decode(response.data['data'])));
          return response;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: userId);
              },
              onDispose: () async {
                await getOrderByUser(userId: userId);
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future getCompletedOrders({
    required String userId,
  }) async {
    var data = {
      'user_id': userId,
    };
    try {
      var response = await dio.post(url + 'getCompletedOrders', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // print(json.encode(json.decode(response.data['data'])));
          return response;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: userId);
              },
              onDispose: () async {
                await getOrderByUser(userId: userId);
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future getCancelledOrders({
    required String userId,
  }) async {
    var data = {
      'user_id': userId,
    };
    try {
      var response = await dio.post(url + 'getCancelledOrders', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // print(json.encode(json.decode(response.data['data'])));
          return response;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: userId);
              },
              onDispose: () async {
                await getOrderByUser(userId: userId);
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future cancelOrder({required int orderId, required String reason}) async {
    var data = {
      'order_id': orderId,
      'reason': reason,
      'user_id': box.read('phoneNum'),
    };

    try {
      var response = await dio.put(url + 'cancelOrder', data: data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat membatalkan pesanan',
              confirmButtonText: 'OK',
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future detailCompleteOrder({required int orderId}) async {
    var data = {
      'order_id': orderId,
    };
    try {
      var response = await dio.post(url + 'detailCompletedOrder', data: data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return response;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat detail pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: box.read('phoneNum'));
              },
              onDispose: () async {
                await getOrderByUser(userId: box.read('phoneNum'));
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future detailCanceledOrder({required int orderId}) async {
    var data = {
      'order_id': orderId,
    };
    try {
      var response = await dio.post(url + 'detailCanceledOrder', data: data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return response;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      ArtSweetAlert.show(
          context: Get.context!,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error',
              text: 'Terjadi kesalahan saat memuat detail pesanan',
              confirmButtonText: 'OK',
              onConfirm: () async {
                await getOrderByUser(userId: box.read('phoneNum'));
              },
              onDispose: () async {
                await getOrderByUser(userId: box.read('phoneNum'));
              },
              confirmButtonColor: RawatinColorTheme.orange));
    }
  }

  Future submitRating({
    required int orderId,
    required double rating,
    required String review,
  }) async {
    var data = {
      'order_id': orderId,
      'rating': rating,
      'customer_notes': review,
    };

    print(data);

    try {
      var response = await dio.put(url + 'submitReview', data: data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {}
  }
}
