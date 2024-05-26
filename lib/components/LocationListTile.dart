import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rawatin/utils/utils.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile(
      {super.key,
      required this.name,
      // required this.locationDetail,
      required this.press});
  // const LocationListTile(
  //     {Key? key, required this.location, required this.press})
  //     : super(key: key);

  final String name;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 20,
          leading: Icon(
            FontAwesomeIcons.locationDot,
            color: RawatinColorTheme.orange,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyle(
                          fontFamily: 'Arial Rounded',
                          fontSize: 15,
                          color: RawatinColorTheme.black),
                      text: name),
                ]),
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // RichText(
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   text: TextSpan(children: [
              //     TextSpan(
              //         style: TextStyle(
              //           fontSize: 12,
              //           color: RawatinColorTheme.grey,
              //         ),
              //         text: locationDetail),
              //   ]),
              // ),
            ],
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: RawatinColorTheme.secondaryGrey,
        ),
      ],
    );
  }
}
