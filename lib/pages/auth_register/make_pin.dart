import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/service/Authentication.dart';
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

class MakePin extends StatefulWidget {
  final String phoneNum;
  final String nama;
  final String email;
  final String birthDate;

  const MakePin(
      {super.key,
      required this.phoneNum,
      required this.nama,
      required this.email,
      required this.birthDate});

  @override
  State<MakePin> createState() => _MakePinState();
}

class _MakePinState extends State<MakePin> {
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
          'Buat PIN Kamu',
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
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Image(image: AssetsLocation.imageLocation('otp')),
              ),
              const Text(
                'PIN akan digunakan setiap kamu login dan melakukan transaksi',
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Pinput(
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
                        await _authenticationService.register(
                            phoneNum: widget.phoneNum,
                            name: widget.nama,
                            email: widget.email,
                            birthDate: widget.birthDate,
                            pin: pin);
                      }();
                    }),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(0, 130, 0, 130)),
              ),
            ],
          ),
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
            bool authenticated = false;
            return Dialog(
              surfaceTintColor: RawatinColorTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        child:
                            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      ),
                      const Text(
                        'Autentikasi Biometrik',
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
                        'Lebih aman, lebih mudah. Gunakan autentikasi biometrik saat kamu login dan buat transaksi',
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Image(
                            image: AssetsLocation.imageLocation('fingerprint')),
                      ),
                      TextButton(
                        onPressed: () async {
                          final authenticate = await LocalAuth.authenticate();
                          setState(() {
                            authenticated = authenticate;
                            if (authenticated) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Authentication failed.'),
                                ),
                              );
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.orange,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: Text('Sip, pakai biometrik aja',
                            style: RawatinColorTheme
                                .secondaryTextTheme.titleSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: RawatinColorTheme.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          side:
                              const BorderSide(color: RawatinColorTheme.orange),
                        ),
                        child: Text(
                          'Ngga, tetap pakai PIN aja',
                          style: RawatinColorTheme.primaryTextTheme.titleSmall,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
