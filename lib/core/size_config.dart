import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static init(BuildContext context) {
    var data = MediaQuery.of(context);
    screenWidth = data.size.width;
    screenHeight = data.size.height;
    orientation = data.orientation;
    defaultSize = Orientation.portrait == orientation
        ? screenWidth * 0.024
        : screenHeight * 0.024;
  }
}
