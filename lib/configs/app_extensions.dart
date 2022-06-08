import 'package:flutter/material.dart';

extension on MaterialColor {
  // Color get appPrimaryColor => Mater

  MaterialColor get appPrimaryColor => MaterialColor(
        _indigoValue,
        <int, Color>{
          500: Color(_indigoValue),
        },
      );
  static const int _indigoValue = 0xFF3F51B5;
}
