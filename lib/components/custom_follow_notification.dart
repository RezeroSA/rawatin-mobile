import 'package:rawatin/components/colors.dart';
import 'package:rawatin/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rawatin/utils/utils.dart';

class CustomFollowNotifcation extends StatefulWidget {
  const CustomFollowNotifcation({Key? key}) : super(key: key);

  @override
  State<CustomFollowNotifcation> createState() =>
      _CustomFollowNotifcationState();
}

class _CustomFollowNotifcationState extends State<CustomFollowNotifcation> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/petugas.png"),
          ),
          SizedBox(
            width: 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Petugas Cuci Mobil",
                  style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Sedang menuju ke alamat kamu",
                style: TextStyle(
                    fontFamily: 'Arial Rounded',
                    fontSize: 15,
                    color: RawatinColorTheme.secondaryGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
