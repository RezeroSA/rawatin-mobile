import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/utils/utils.dart';

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

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            const Text(
              'Kami sudah mengirimkan kode One Time Password ke nomor +62 8xx xxxx xxxx',
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
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                validator: (s) {
                  return s == '2222' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => (
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => const Home(),
                    ),
                  ),
                ),
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
                        ..onTap = () => _showDialog(context)),
                ],
              ),
            )
          ],
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
