import 'package:flutter/material.dart';

/// Defines the app's name
const String kAppName = 'Trivia';

/// Defines app current version
const String kAppVersion = '2.0.0';

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
const Color kDarkPrimaryColor = Color(0xFF303F9F);
const Color kLightPrimaryColor = Color(0xFFC5CAE9);
const Color kAccentColor = Color(0xFFFF9800);
const Color kPrimaryTextColor = Color(0xFF212121);
const Color kSecondaryTextColor = Color(0xFF757575);
const Color kDividerColor = Color(0xFFBDBDBD);
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

// time for each type of difficulty
const int kTimeLengthForEasyDifficulty = 20;
const int kTimeLengthForMediumDifficulty = 40;
const int kTimeLengthForHardDifficulty = 60;

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

/// Get textTheme
TextStyle? kGetQuestionFormHeaderTheme(BuildContext context) {
  return Theme.of(context).textTheme.headline5;
}

/// Assets images
class AssetsImages {
  static const String logoIcon = 'assets/images/logo.png';
  static const String appIcon = 'assets/images/app_icon.png';
  static const String authBannerImg = 'assets/images/auth/auth_banner.svg';
  static const String homeBannerImg = 'assets/images/auth/home_banner.png';
  static const String mathImg = 'assets/images/category/math_img.png';
  static const String animalsImg = 'assets/images/category/animals_img.png';
  static const String animeImg = 'assets/images/category/anime_img.png';
  static const String anyImg = 'assets/images/category/any_img.png';
  static const String artImg = 'assets/images/category/art_img.png';
  static const String boardGameImg = 'assets/images/category/board_game_img.png';
  static const String booksImg = 'assets/images/category/books_img.png';
  static const String cartoonImg = 'assets/images/category/cartoon_img.png';
  static const String celebritiesImg = 'assets/images/category/celebrities_img.png';
  static const String comicImg = 'assets/images/category/comic_img.png';
  static const String computersImg = 'assets/images/category/computers_img.png';
  static const String filmImg = 'assets/images/category/film_img.png';
  static const String gadgetsImg = 'assets/images/category/gadgets_img.png';
  static const String generalImg = 'assets/images/category/general_img.png';
  static const String geoImg = 'assets/images/category/geo_img.png';
  static const String historyImg = 'assets/images/category/history_img.png';
  static const String musicImg = 'assets/images/category/music_img.png';
  static const String mythImg = 'assets/images/category/myth_img.png';
  static const String natureImg = 'assets/images/category/nature_img.png';
  static const String politicsImg = 'assets/images/category/politics_img.png';
  static const String sportsImg = 'assets/images/category/sports_img.png';
  static const String televisionImg = 'assets/images/category/television_img.png';
  static const String theaterImg = 'assets/images/category/theater_img.png';
  static const String vehiclesImg = 'assets/images/category/vehicles_img.png';
  static const String videoGameImg = 'assets/images/category/video_game_img.png';
  static const String coinsImg = 'assets/images/coins.png';
}

class AssetsAnimations {
  static const String wellDone = 'assets/animations/well_done_anim.json';
  static const String lookingEyes = 'assets/animations/looking_eyes.json';
  static const String congrats = 'assets/animations/congratulation-success-batch.json';
  static const String thumbsUp = 'assets/animations/thumb-up-party.json';
  static const String loss = 'assets/animations/you-loss.json';
  static const String noInternet = 'assets/animations/cat_anim.json';
}
