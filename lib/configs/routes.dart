import 'package:flutter/material.dart';

import '../core/auth/screens/auth_screen.dart';
import '../screens/settings.dart';
import '../core/game/categories.dart';
import '../core/game/screens/quiz_page.dart';


/// Defines established routes in the application
class Routes {
  static const auth = '/auth';
  static const categories = '/categories';
  static const settings = '/settings';
  static const quiz = '/quiz';

  /// Route generator. This will list all the available routes in the application
  Map<String, Widget Function(BuildContext)> generateRoutes(BuildContext context) {
    return {
      auth: (ctx) => const AuthScreen(),
      categories: (ctx) => const Categories(),
      settings: (ctx) => Settings(),
      quiz: (ctx) => QuizPage(),
    };
  }
}
