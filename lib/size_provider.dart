import 'package:flutter/material.dart';

class SizeProvider {
  static late double screenWidthFactor;
  static late double screenHeightFactor;
  static late Orientation orientation;
  void init(context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    orientation = mediaQueryData.orientation;
    Size screenSize = mediaQueryData.size;
    screenHeightFactor = screenSize.height / 1280;
    screenWidthFactor = screenSize.width / 590;
  }
}

double getProportionalHeight(double height) {
  return SizeProvider.screenHeightFactor * height;
}

double getProportionalWidth(double width) {
  return SizeProvider.screenWidthFactor * width;
}
