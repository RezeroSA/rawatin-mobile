import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/auth_register/register_form.dart';
import 'package:rawatin/service/Authentication.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:get/get.dart';

final defaultPinTheme = PinTheme(
  width: 52,
  height: 72,
  textStyle: const TextStyle(
      fontSize: 20,
      color: RawatinColorTheme.black,
      fontWeight: FontWeight.w700),
  decoration: BoxDecoration(
    border: Border.all(color: RawatinColorTheme.grey),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: RawatinColorTheme.orange),
);

class AuthRegister extends StatefulWidget {
  final String phoneNum;

  AuthRegister({super.key, required this.phoneNum});

  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  final pinController = TextEditingController();
  final AuthenticationService _authenticationService =
      Get.put(AuthenticationService());

  @override
  Widget build(BuildContext context) {
    String formattedPhoneNum = formatPhoneNumber('0' + widget.phoneNum);
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Verifikasi OTP',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              Text(
                'Kami sudah mengirimkan kode One Time Password ke nomor WhatsApp ${formattedPhoneNum}',
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Image(image: AssetsLocation.imageLocation('otp')),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Pinput(
                  controller: pinController,
                  length: 6,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  closeKeyboardWhenCompleted: true,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    // print(pin);
                    () async {
                      await _authenticationService.verifyRegistrationOTP(
                          phoneNum: widget.phoneNum, otp: pin);
                    }();
                  },
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      style: TextStyle(color: RawatinColorTheme.black),
                      text: 'Tidak menerima OTP? ',
                    ),
                    TextSpan(
                        style: const TextStyle(
                            color: RawatinColorTheme.orange,
                            fontFamily: 'Arial Rounded'),
                        text: 'Kirim ulang OTP',
                        recognizer: TapGestureRecognizer()
                          // ..onTap = () => _showDialog(context),
                          ..onTap = () {
                            () async {
                              await _authenticationService.resendOTP(
                                  phoneNum: widget.phoneNum.trim());
                              _showDialog(context);
                              pinController.clear();
                            }();
                          }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_showDialog(BuildContext context) {
  showDialog(
      builder: (context) => CupertinoAlertDialog(
            title: const Column(
              children: <Widget>[
                Text("OTP sudah dikirim"),
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 100,
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  "OK",
                  style: TextStyle(color: RawatinColorTheme.orange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
      context: context);
}

String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAllMapped(
    RegExp(r".{4}"),
    (Match match) => "${match.group(0)} ",
  );
}
