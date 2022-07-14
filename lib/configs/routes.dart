import 'package:flutter/material.dart';

import '../core/auth/screens/auth_screen.dart';
import '../screens/settings.dart';
import '../core/game/categories.dart';
import '../core/game/screens/quiz_page.dart';
import '../core/game/screens/quiz_result.dart';
import '../core/nav_screen.dart';
import '../core/dashboard/history_view.dart';

/// Defines established routes in the application
class Routes {
  static const auth = '/auth';
  static const navScreen = '/nav';
  static const categories = '/categories';
  static const quiz = '/quiz';
  static const result = '/result';
  static const history = '/history';

  /// Route generator. This will list all the available routes in the application
  Map<String, Widget Function(BuildContext)> generateRoutes(BuildContext context) {
    return {
      auth: (ctx) => const AuthScreen(),
      navScreen: (ctx) => const NavScreen(),
      categories: (ctx) => const Categories(),
      quiz: (ctx) => const QuizPage(transportedData: {'questions': []}),
      result: (ctx) => const QuizResult(),
      history: (ctx) => const HistoryView(),
    };
  }
}
