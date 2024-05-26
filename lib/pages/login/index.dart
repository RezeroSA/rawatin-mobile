import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawatin/pages/auth_login/index.dart';
import 'package:rawatin/service/Authentication.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNum = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService =
      Get.put(AuthenticationService());

  late String numberInput;

  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            IntlPhoneField(
                              controller: _phoneNum,
                              decoration: const InputDecoration(
                                labelText: 'Nomor HP',
                                labelStyle:
                                    TextStyle(color: RawatinColorTheme.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: RawatinColorTheme.black),
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
                              keyboardType: TextInputType.phone,
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState == null) {
                                  _showDialog(context);
                                } else if (_phoneNum.text.length == 0) {
                                  _showDialog(context);
                                } else if (_phoneNum.text.length < 11) {
                                  _showDialogTidakLengkap(context);
                                } else if (_formKey.currentState!.validate()) {
                                  if (_phoneNum.text.length == 0) {
                                    _showDialog(context);
                                  } else {
                                    () async {
                                      await _authenticationService
                                          .checkExistingNumberLogin(
                                              phoneNum: _phoneNum.text.trim());
                                    }();
                                  }
                                }
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

_showDialog(BuildContext context) {
  showDialog(
      builder: (context) => CupertinoAlertDialog(
            title: const Column(
              children: <Widget>[
                Text("Nomor HP tidak boleh kosong"),
                Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
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

_showDialogTidakLengkap(BuildContext context) {
  showDialog(
      builder: (context) => CupertinoAlertDialog(
            title: const Column(
              children: <Widget>[
                Text("Nomor HP minimal 11 digit"),
                Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
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
