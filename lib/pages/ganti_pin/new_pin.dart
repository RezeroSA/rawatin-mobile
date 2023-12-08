import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/home/index.dart';
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

class NewPin extends StatefulWidget {
  const NewPin({super.key});

  @override
  State<NewPin> createState() => _NewPinState();
}

class _NewPinState extends State<NewPin> {
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
              'Masukkin PIN baru kamu',
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
                    _autentikasiBiometrik(context);
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

_autentikasiBiometrik(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              surfaceTintColor: RawatinColorTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 420),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      ),
                      const Text(
                        'Berhasil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Arial Rounded',
                        ),
                      ),
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      ),
                      const Text(
                        'PIN kamu berhasil diubah',
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Image(
                            image: AssetsLocation.imageLocation('ganti-pin')),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.orange,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: Text('Selesai',
                            style: RawatinColorTheme
                                .secondaryTextTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
