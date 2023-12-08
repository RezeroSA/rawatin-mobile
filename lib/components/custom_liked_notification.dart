import 'package:rawatin/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rawatin/utils/utils.dart';

class CustomLikedNotifcation extends StatelessWidget {
  const CustomLikedNotifcation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          const SizedBox(
            height: 80,
            width: 80,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/petugas.png"),
                ),
              ),
              Positioned(
                bottom: 10,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/petugas2.png"),
                ),
              ),
            ]),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  maxLines: 2,
                  text: const TextSpan(
                      text: "Ban Bocor dan ",
                      style: TextStyle(
                          fontFamily: 'Arial Rounded',
                          fontSize: 20,
                          color: RawatinColorTheme.black),
                      children: [
                        TextSpan(
                            text: " Tersesat",
                            style: TextStyle(
                                fontFamily: 'Arial Rounded', fontSize: 20)),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("2 orang petugas Rawat.in akan membantu kamu",
                    style: TextStyle(
                        fontFamily: 'Arial Rounded',
                        fontSize: 15,
                        color: RawatinColorTheme.secondaryGrey)),
              ],
            ),
          ),
          Image.asset(
            "assets/images/ban-bocor-bukti.png",
            height: 64,
            width: 64,
          ),
        ],
      ),
    );
  }
}
