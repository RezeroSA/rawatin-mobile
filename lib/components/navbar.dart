import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: BottomAppBar(
        height: 95,
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 60,
            color: RawatinColorTheme.grey.withOpacity(0.2),
            child: Row(
              children: [
                navItem(
                  Icons.home_outlined,
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                navItem(
                  Icons.warning_rounded,
                  pageIndex == 1,
                  onTap: () => onTap(1),
                ),
                navItem(
                  Icons.receipt_long,
                  pageIndex == 2,
                  onTap: () => onTap(2),
                ),
                navItem(
                  Icons.person_outline,
                  pageIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Icon(
            icon,
            size: 40,
            // color: RawatinColorTheme.black,
            color: icon == Icons.warning_rounded
                ? RawatinColorTheme.red
                : RawatinColorTheme.black,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 5),
            height: 4,
            width: 45,
            decoration: selected
                ? const BoxDecoration(
                    color: RawatinColorTheme.orange,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                : const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
      ]),
    );
  }
}
