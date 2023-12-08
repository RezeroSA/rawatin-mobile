import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawatin/pages/auth_login/index.dart';
import 'package:rawatin/utils/utils.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
          child: Column(
            children: [
              Image(image: AssetsLocation.imageLocation('login')),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Masukkan nomor HP',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Arial Rounded')),
                    const Text(
                      'Untuk masuk ke akunmu atau daftar kalau kamu baru di Rawat.in',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          IntlPhoneField(
                            decoration: const InputDecoration(
                              labelText: 'Nomor HP',
                              labelStyle:
                                  TextStyle(color: RawatinColorTheme.black),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: RawatinColorTheme.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: RawatinColorTheme.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            initialCountryCode: 'ID',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthLogin()),
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: RawatinColorTheme.orange,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            child: Text('Lanjut',
                                style: RawatinColorTheme
                                    .secondaryTextTheme.titleSmall),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}