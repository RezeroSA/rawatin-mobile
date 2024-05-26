import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/auth_login/index.dart';
import 'package:rawatin/pages/auth_login/input_pin.dart';
import 'package:rawatin/pages/auth_login/reset_pin.dart';
import 'package:rawatin/pages/auth_register/index.dart';
import 'package:rawatin/pages/auth_register/register_form.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/pages/welcome_page/index.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:quickalert/quickalert.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:dio/src/form_data.dart' hide FormData;

class AuthenticationService extends GetxController {
  final isLoading = false.obs;
  final isResend = false.obs;
  final dio = Dio();
  final box = GetStorage();

  Future checkExistingNumber({
    required String phoneNum,
  }) async {
    isLoading.value = true;
    var data = {'phone': '0' + phoneNum};

    try {
      var response = await dio.post(url + 'checkExistingNumber', data: data);

      // print(response.data['status']);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          isLoading.value = false;
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'Nomor yang kamu masukin sudah terdaftar',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
            autoCloseDuration: Duration(seconds: 5),
          );
        } else {
          isLoading.value = false;

          var otp = await dio.post(url + 'sendRegisterOTP', data: data);

          // print(otp);

          if (otp.statusCode == 200) {
            Get.to(() => AuthRegister(phoneNum: phoneNum));
          } else {
            QuickAlert.show(
              context: Get.context!,
              type: QuickAlertType.error,
              animType: QuickAlertAnimType.slideInUp,
              title: 'Oops...',
              text: 'Gagal mengirimkan OTP',
              confirmBtnText: 'OK',
              confirmBtnColor: RawatinColorTheme.orange,
              autoCloseDuration: Duration(seconds: 5),
            );
          }
        }
      } else {
        isLoading.value = false;
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      isLoading.value = false;
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future checkExistingNumberLogin({
    required String phoneNum,
  }) async {
    isLoading.value = true;
    var data = {'phone': '0' + phoneNum};

    try {
      var response = await dio.post(url + 'checkExistingNumber', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          print(response);
          var otp = await dio.post(url + 'sendLoginOTP', data: data);
          if (otp.statusCode == 200) {
            isResend.value = true;
            Get.to(() => AuthLogin(phoneNum: phoneNum));
          } else {
            QuickAlert.show(
              context: Get.context!,
              type: QuickAlertType.error,
              animType: QuickAlertAnimType.slideInUp,
              title: 'Oops...',
              text: 'Gagal mengirim OTP',
              confirmBtnText: 'OK',
              confirmBtnColor: RawatinColorTheme.orange,
              autoCloseDuration: Duration(seconds: 5),
            );
          }
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.warning,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text:
                'Nomor yang kamu masukin belum terdaftar, klik OK untuk membuat akun',
            confirmBtnText: 'OK',
            showCancelBtn: true,
            cancelBtnText: 'Tidak',
            onConfirmBtnTap: () => Get.to(() => Register()),
            confirmBtnColor: RawatinColorTheme.orange,
          );
        }
      } else {
        isLoading.value = false;
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future resendOTP({
    required String phoneNum,
  }) async {
    var data = {'phone': '0' + phoneNum};

    try {
      var otp = await dio.post(url + 'sendRegisterOTP', data: data);
      if (otp.statusCode == 200) {
        isResend.value = true;
        // print(otp);
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future resendOTPLogin({
    required String phoneNum,
  }) async {
    var data = {'phone': '0' + phoneNum};

    try {
      var otp = await dio.post(url + 'sendLoginOTP', data: data);
      if (otp.statusCode == 200) {
        isResend.value = true;
        // print(otp);
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future recoveryOTP({
    required String phoneNum,
  }) async {
    var data = {'phone': '0' + phoneNum};

    try {
      var otp = await dio.post(url + 'sendRecoveryOTP', data: data);
      if (otp.statusCode == 200) {
        isResend.value = true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future verifyRegistrationOTP({
    required String phoneNum,
    required String otp,
  }) async {
    var data = {'phone': '0' + phoneNum, 'otp': otp};

    try {
      var response = await dio.post(url + 'verifyRegistrationOTP', data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // Get.to(() => RegisterForm(phoneNum: phoneNum));
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Yay!',
            text: 'OTP berhasil di verifikasi',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
          Get.to(() => RegisterForm(phoneNum: phoneNum));
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'OTP yang kamu masukkan salah',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future verifyLoginOTP({
    required String phoneNum,
    required String otp,
  }) async {
    var data = {'phone': '0' + phoneNum, 'otp': otp};

    try {
      var response = await dio.post(url + 'verifyLoginOTP', data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // Get.to(() => RegisterForm(phoneNum: phoneNum));
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Yay!',
            text: 'OTP berhasil di verifikasi',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
          Get.to(() => InputPin(phoneNum: phoneNum));
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'OTP yang kamu masukkan salah',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future verifyRecoveryOTP({
    required String phoneNum,
    required String otp,
  }) async {
    var data = {'phone': '0' + phoneNum, 'otp': otp};

    try {
      var response = await dio.post(url + 'verifyRecoveryOTP', data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // Get.to(() => RegisterForm(phoneNum: phoneNum));
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Yay!',
            text: 'OTP berhasil di verifikasi',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
          Get.to(() => ResetPIN(phoneNum: phoneNum));
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'OTP yang kamu masukkan salah',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future login({
    required String phoneNum,
    pin,
  }) async {
    var data = {'phone': '0' + phoneNum, 'pin': pin};

    try {
      var login = await dio.post(url + 'login', data: data);

      if (login.statusCode == 200) {
        if (login.data['status'] == true) {
          print(login.data);
          box.write('token', login.data['access_token']);
          box.write('name', login.data['data']['name']);
          box.write('phoneNum', login.data['data']['phone']);
          box.write('pin', pin);
          if (login.data['data']['email'] != null) {
            box.write('email', login.data['data']['email']);
          } else {
            box.write('email', 'Email belum diatur');
          }
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Yay!',
            text: 'Login Berhasil',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
            autoCloseDuration: Duration(seconds: 5),
          ).then((value) => Get.offAll(() => const Home()));
          return true;
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'PIN yang kamu masukkan salah',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
          );
          return false;
        }
      }
    } catch (e) {}
  }

  Future register({
    required String phoneNum,
    required String name,
    required String email,
    required String birthDate,
    required String pin,
  }) async {
    var data = {
      'name': name,
      'phone': '0' + phoneNum,
      'email': email,
      'bday': birthDate,
      'pin': pin
    };

    try {
      var response = await dio.post(url + 'register', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          await login(phoneNum: phoneNum, pin: pin);
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'Pendaftaran gagal, silahkan coba beberapa saat lagi',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
            autoCloseDuration: Duration(seconds: 5),
          );
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future resetPIN({required String phoneNum, required String pin}) async {
    var data = {'phone': '0' + phoneNum, 'pin': pin};

    try {
      var response = await dio.post(url + 'resetPIN', data: data);

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          box.write('token', response.data['access_token']);
          box.write('name', response.data['data']['name']);
          box.write('phoneNum', response.data['data']['phone']);
          box.write('pin', pin);

          if (response.data['data']['email'] != null) {
            box.write('email', response.data['data']['email']);
          } else {
            box.write('email', 'Email belum diatur');
          }

          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'Gagal menyambungkan ke server',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
            autoCloseDuration: Duration(seconds: 5),
          ).then((value) => Get.offAll(() => const Home()));
          return true;
        } else {
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            animType: QuickAlertAnimType.slideInUp,
            title: 'Oops...',
            text: 'Reset PIN Gagal',
            confirmBtnText: 'OK',
            confirmBtnColor: RawatinColorTheme.orange,
            autoCloseDuration: Duration(seconds: 5),
          ).then((value) => Get.offAll(() => const WelcomePage()));
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          animType: QuickAlertAnimType.slideInUp,
          title: 'Oops...',
          text: 'Gagal menyambungkan ke server',
          confirmBtnText: 'OK',
          confirmBtnColor: RawatinColorTheme.orange,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
    } catch (e) {}
  }

  Future getProfile({required String phoneNum}) async {
    var data = {'phone': phoneNum};
    try {
      var response = await dio.post(url + 'getProfile', data: data);
      print('res: ${response.data}');
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
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInUp,
        title: 'Oops...',
        text: 'Gagal menyambungkan ke server',
        confirmBtnText: 'OK',
        confirmBtnColor: RawatinColorTheme.orange,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  Future updateProfile(
      {required String name,
      required String email,
      required String bday,
      required XFile? avatar}) async {
    // var data = {
    //   'name': name,
    //   'email': email,
    //   'bday': bday,
    //   'avatar': formData,
    //   'phone': box.read('phoneNum')
    // };

    if (avatar != null) {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'bday': bday,
        'phone': box.read('phoneNum'),
        "avatar":
            await MultipartFile.fromFile(avatar!.path, filename: avatar.name),
      });

      try {
        var res = await dio.post(url + 'updateProfile', data: formData);

        if (res.statusCode == 200) {
          print(res);
          if (res.data['status'] == true) {
            box.remove('name');
            box.remove('email');
            box.write('name', res.data['data']['name']);
            box.write('email', res.data['data']['email']);

            return true;
          } else {
            return false;
          }
        }
      } catch (e) {
        print(e);
        ArtSweetAlert.show(
            context: Get.context!,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: 'Error',
                text: 'Gagal saat menyimpan data profil, silahkan coba lagi',
                confirmButtonText: 'OK',
                confirmButtonColor: RawatinColorTheme.orange));
      }
    } else {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'bday': bday,
        'phone': box.read('phoneNum'),
        "avatar": null,
      });

      try {
        var res = await dio.post(url + 'updateProfile', data: formData);

        if (res.statusCode == 200) {
          print(res);
          if (res.data['status'] == true) {
            box.write('name', res.data['data']['name']);
            box.write('email', res.data['data']['email']);

            return true;
          } else {
            return false;
          }
        }
      } catch (e) {
        print(e);
        ArtSweetAlert.show(
            context: Get.context!,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: 'Error',
                text: 'Gagal saat menyimpan data profil, silahkan coba lagi',
                confirmButtonText: 'OK',
                confirmButtonColor: RawatinColorTheme.orange));
      }
    }
  }

  Future logout() async {
    try {
      // var data = {'phone': box.read('phoneNum')};
      // print(data);
      // var response = await dio.post(url + 'logout', data: data);
      // print(response.data);

      await box.remove('token');
      await box.remove('pin');
      await box.remove('name');
      await box.remove('phoneNum');
      await box.remove('email');

      Get.offAll(() => const WelcomePage());
    } catch (e) {
      print(e);
    }
  }
}
