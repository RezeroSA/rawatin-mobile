import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetsLocation.imageLocation('logo'),
      width: 80,
    );
  }
}
