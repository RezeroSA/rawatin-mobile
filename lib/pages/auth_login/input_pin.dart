import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/auth_login/lupa_pin.dart';
import 'package:rawatin/pages/home/index.dart';
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

class InputPin extends StatefulWidget {
  final String phoneNum;
  const InputPin({super.key, required this.phoneNum});

  @override
  State<InputPin> createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
  final pinController = TextEditingController();
  final AuthenticationService _authenticationService =
      Get.put(AuthenticationService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Masukkan PIN Kamu',
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
              // Text(
              //   'Kami sudah mengirimkan kode One Time Password ke nomor WhatsApp ${formattedPhoneNum}',
              //   textAlign: TextAlign.center,
              // ),
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
                  obscureText: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    () async {
                      var login = await _authenticationService.login(
                          phoneNum: widget.phoneNum, pin: pin);
                      if (login) {
                        pinController.clear();
                      } else {
                        pinController.clear();
                      }
                    }();
                  },
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      style: TextStyle(color: RawatinColorTheme.black),
                      text: 'Lupa PIN? ',
                    ),
                    TextSpan(
                        style: const TextStyle(
                            color: RawatinColorTheme.orange,
                            fontFamily: 'Arial Rounded'),
                        text: 'Atur ulang PIN saya',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            () async {
                              var response =
                                  await _authenticationService.recoveryOTP(
                                      phoneNum: widget.phoneNum.trim());
                              pinController.clear();

                              if (response) {
                                Get.to(() => LupaPin(
                                      phoneNum: widget.phoneNum,
                                    ));
                              }
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

String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAllMapped(
    RegExp(r".{4}"),
    (Match match) => "${match.group(0)} ",
  );
}
