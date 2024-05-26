import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/order_page/index.dart';
import 'package:rawatin/utils/utils.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile(
      {super.key,
      required this.name,
      required this.locationDetail,
      required this.press});
  // const LocationListTile(
  //     {Key? key, required this.location, required this.press})
  //     : super(key: key);

  final String name;
  final String locationDetail;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: RawatinColorTheme.red,
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => const OrderPageMain(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image(
                          image:
                              AssetsLocation.imageLocation('kecelakaan-putih'),
                          height: 40,
                          width: 40,
                        ),
                      )),
                  const SizedBox(
                    width: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kecelakaan',
                          style: TextStyle(
                              fontFamily: 'Arial Rounded',
                              fontSize: 16,
                              color: RawatinColorTheme.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Expanded(
                          child: Text(
                            'Kendaraan saya mengalami kecelakaan dan butuh pertolongan sekarang juga',
                            style: TextStyle(
                                color: RawatinColorTheme.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Column(
    //   children: [
    //     ListTile(
    //       onTap: press,
    //       horizontalTitleGap: 20,
    //       leading: Icon(
    //         FontAwesomeIcons.locationDot,
    //         color: RawatinColorTheme.orange,
    //       ),
    //       title: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           RichText(
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //             text: TextSpan(children: [
    //               TextSpan(
    //                   style: TextStyle(
    //                       fontFamily: 'Arial Rounded',
    //                       fontSize: 17,
    //                       color: RawatinColorTheme.black),
    //                   text: name),
    //             ]),
    //           ),
    //           SizedBox(
    //             height: 8,
    //           ),
    //           RichText(
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //             text: TextSpan(children: [
    //               TextSpan(
    //                   style: TextStyle(
    //                     fontSize: 12,
    //                     color: RawatinColorTheme.grey,
    //                   ),
    //                   text: locationDetail),
    //             ]),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const Divider(
    //       height: 2,
    //       thickness: 2,
    //       color: RawatinColorTheme.secondaryGrey,
    //     ),
    //   ],
    // );
  }
}
