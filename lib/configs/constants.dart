import 'package:flutter/material.dart';

/// Defines the app's name
const String kAppName = 'Trivia';

/// Defines app current version
const String kAppVersion = '1.0.0';

/// Theme font
const String kFontFamily = 'Ubuntu';

// Colors
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF000000);
const Color kGrey = Color(0xFFEBEBEB);
const Color kCanvasColor = Color(0xFFE8EAF6);
const Color kLightBlack = Colors.black26;
const Color kDeepGrey = Color(0xFF4A4A4A);
const Color kPrimaryColor = Color(0xFF3F51B5);
const Color kRed = Color(0xFF960000);
const Color kTransparent = Colors.transparent;

// Padding
const double kPaddingS = 10.0;
const double kPaddingM = 20.0;
const double kPaddingL = 40.0;

// Border Radius
const double kSmallRadius = 12.0;
const double kMediumRadius = 20.0;
const double kLargeRadius = 50.0;

const double kButtonHeight = 52.0;
const double kCardElevation = 5.0;
const double kButtonRadius = 10.0;
const double kDialogRadius = 20.0;

/// Get screen height
double kScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Get screen width
double kScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Get screen orientation
Orientation kGetOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

/// Assets images
class AssetsImages {
  static const String logoIcon = 'assets/images/logo.png';
  static const String appIcon = 'assets/images/app_icon.png';
  static const String authBannerImg = 'assets/images/auth/auth-banner.svg';
}

class AssetsAnimations {
  static const String wellDone = 'assets/animations/well_done_anim.json';
}
