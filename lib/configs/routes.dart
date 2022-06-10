import 'package:flutter/material.dart';

import '../core/auth/screens/auth_screen.dart';
import '../screens/settings.dart';
import '../core/game/categories.dart';

/// Defines established routes in the application
class Routes {
  static const auth = '/auth';
  static const categories = '/categories';
  static const settings = '/settings';

  /// Route generator. This will list all the available routes in the application
  Map<String, Widget Function(BuildContext)> generateRoutes(BuildContext context) {
    return {
      auth: (ctx) => const AuthScreen(),
      categories: (ctx) => const Categories(),
      settings: (ctx) => Settings()
      // Categories.routeName: (ctx) => Categories(),
      // BuildQuestion.routeName: (ctx) => BuildQuestion(),
      // QuizPage.routeName: (ctx) => QuizPage(),
      // ViewAnswers.routeName: (ctx) => ViewAnswers(),
      // HistoryScreen.routeName: (ctx) => HistoryScreen(),
      // Settings.routeName: (ctx) => Settings(),
    };
  }
}
