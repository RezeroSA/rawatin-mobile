import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as ui;
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawatin/service/Authentication.dart';
import 'package:rawatin/utils/utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _phoneNum = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService =
      Get.put(AuthenticationService());

  late String numberInput;

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return ui.Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: ui.AppBar(
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
                    const Text('Masukkan nomor Hp',
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
                              decoration: const ui.InputDecoration(
                                labelText: 'Nomor HP',
                                labelStyle:
                                    TextStyle(color: RawatinColorTheme.black),
                                border: ui.OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: RawatinColorTheme.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: ui.OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: RawatinColorTheme.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              initialCountryCode: 'ID',
                              keyboardType: TextInputType.phone,
                            ),
                            ui.TextButton(
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
                                          .checkExistingNumber(
                                              phoneNum: _phoneNum.text.trim());
                                    }();
                                  }
                                }
                              },
                              style: ui.TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                backgroundColor: RawatinColorTheme.orange,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              child: Text('Daftar',
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
  ui.showDialog(
      builder: (context) => CupertinoAlertDialog(
            title: const Column(
              children: <Widget>[
                Text("Nomor HP tidak boleh kosong"),
                Icon(
                  ui.Icons.warning_rounded,
                  color: ui.Colors.red,
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
  ui.showDialog(
      builder: (context) => CupertinoAlertDialog(
            title: const Column(
              children: <Widget>[
                Text("Nomor HP minimal 11 digit"),
                Icon(
                  ui.Icons.warning_rounded,
                  color: ui.Colors.red,
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
