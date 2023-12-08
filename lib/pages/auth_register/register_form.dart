import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rawatin/pages/auth_register/index.dart';
import 'package:rawatin/pages/auth_register/make_pin.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            children: [
              Image(image: AssetsLocation.imageLocation('register_fill')),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Yuk lengkapi data kamu',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Arial Rounded')),
                    const Text(
                      'Data yang kamu isi disini bakal dipakai untuk memproses pesanan kamu nanti',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.person),
                              labelText: 'Nama Lengkap',
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
                          ),
                          const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          ),
                          TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              labelText: 'Tanggal Lahir',
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
                            controller: dateController,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now(), //get today's date
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(
                                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                print(
                                    formattedDate); //formatted date output using intl package =>  2022-07-04
                                //You can format date as per your need

                                setState(() {
                                  dateController.text =
                                      formattedDate; //set foratted date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.email_outlined),
                              labelText: 'Email',
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
                          ),
                          const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MakePin()),
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
