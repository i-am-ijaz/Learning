import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? width;
  static double? height;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.maybeOf(context);
    width = _mediaQueryData?.size.width;
    height = _mediaQueryData?.size.height;
    orientation = _mediaQueryData?.orientation;
  }
}

double getProportionalScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.height ?? 812;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionalScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.width ?? 375;
  return (inputWidth / 375.0) * screenWidth;
}
