import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/ganti_pin/new_pin.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/pages/register/index.dart';
import 'package:rawatin/pages/welcome_page/index.dart';
import 'package:rawatin/utils/local_auth.dart';
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

class GantiPin extends StatefulWidget {
  const GantiPin({super.key});

  @override
  State<GantiPin> createState() => _GantiPinState();
}

class _GantiPinState extends State<GantiPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Ganti PIN',
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
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Image(image: AssetsLocation.imageLocation('otp')),
            ),
            const Text(
              'Masukkin PIN lama kamu',
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                validator: (s) {
                  if (s == '222222') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewPin()),
                    );
                  } else {
                    'Pin is incorrect';
                  }
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            const SizedBox(
              child: Padding(padding: EdgeInsets.fromLTRB(0, 130, 0, 130)),
            ),
          ],
        ),
      ),
    );
  }
}
