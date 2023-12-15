import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _type = 1;

  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(width: 1, color: RawatinColorTheme.orange)
                        : Border.all(width: 0.3, color: RawatinColorTheme.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: RawatinColorTheme.orange,
                              ),
                              const Text(
                                "Tunai",
                                style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: AssetsLocation.imageLocation('cash'),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: RawatinColorTheme.orange)
                        : Border.all(width: 0.3, color: RawatinColorTheme.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: RawatinColorTheme.orange,
                              ),
                              const Text(
                                "E-Wallet",
                                style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: AssetsLocation.imageLocation('e-wallet'),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 3
                        ? Border.all(width: 1, color: RawatinColorTheme.orange)
                        : Border.all(width: 0.3, color: RawatinColorTheme.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: RawatinColorTheme.orange,
                              ),
                              const Text(
                                "Kartu kredit atau debit",
                                style: TextStyle(
                                  fontFamily: 'Arial Rounded',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: AssetsLocation.imageLocation('credit'),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.49,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: RawatinColorTheme.orange,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: Text('Selesai',
                      style: RawatinColorTheme.secondaryTextTheme.titleSmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
