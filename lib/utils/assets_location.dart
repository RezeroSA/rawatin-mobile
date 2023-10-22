import 'package:flutter/material.dart';

class AssetsLocation {
  static ImageProvider imageLocation(String imageName) {
    final location = AssetImage('assets/images/$imageName.png');
    return location;
  }
}
