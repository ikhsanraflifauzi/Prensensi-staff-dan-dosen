import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();
// Clear blue
  static Color lightClearBlue = hexToColor('#0E8388');
  static Color darkClearBlue = hexToColor('#2E4F4F');
  static Color veryClearBlue = hexToColor('#CBE4DE');
  static Color hightOrange = hexToColor('#F90000');

  // Gray Color
  static Color gray50 = hexToColor('#e9e9e9');
  static Color gray100 = hexToColor('#bdbebe');
  static Color gray200 = hexToColor('#929293');
  static Color gray300 = hexToColor('#666667');
  static Color gray400 = hexToColor('#505151');
  static Color gray500 = hexToColor('#242526');
  static Color gray600 = hexToColor('#202122');
  static Color gray700 = hexToColor('#191a1b');
  static Color gray800 = hexToColor('#121313');
  static Color gray900 = hexToColor('#0e0f0f');
  static Color greyTextField = hexToColor('#D9D9D9');
  static Color grey40 = hexToColor('#F3F3F3');
  static Color green1 = hexToColor('#15C8A8');
  static Color green2 = hexToColor('#3AAA35');
  static Color whitegray = hexToColor('#EDEDED');
  static Color cyan1 = hexToColor('#15C8A8');
  // static Color mainBlue = hexToColor('#83B4E1');
  static Color mainBlue = hexToColor('#106FA4');
  static Color mainPurple = hexToColor('#B7B5FC');
  static Color blue50 = hexToColor('#B4D6FF');
  static Color blue1 = hexToColor('#0E69D3');
  static Color blue2 = hexToColor('#106FA4');
  static Color yellow1 = hexToColor('#EFE05B');
  static Color yellow2 = hexToColor('#B6750A');
  static Color yellow3 = hexToColor('#D9940F');
  static Color yellow4 = hexToColor('#FDCD4F');
  static Color dropdown = hexToColor('#3AAA35');
  static Color purple100 = hexToColor('#B8B8FF');
  static Color mainColorBlue = hexToColor('#106FA4');
  static Color indicator = hexToColor('#15C8A8');
  static Color mainColorPink = hexToColor('#EE3167');
  static Color mainColorYellow = hexToColor('#FDB415');
  static Color red = hexToColor('#EE2D24');
  static Color background = hexToColor('#F3F3F3');
  static Color backgroundLight = hexToColor('#F9F9F9');
  static Color errorColor = hexToColor('#DB3022');
  static Color labelBlack = hexToColor('#383838');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
