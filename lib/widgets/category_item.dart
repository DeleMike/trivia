import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../screens/build_question.dart';

///[CategoryItem] is used to display a particular category item to the screen 
class CategoryItem extends StatelessWidget {
  final String categoryName;
  final int categoryTag;

  CategoryItem({
    required this.categoryName,
    required this.categoryTag,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
          builder: (ctx, themeProvider, __) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(BuildQuestion.routeName, arguments: {
            'name' : categoryName,
            'tag' : categoryTag,
          },);
        },
        splashColor: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            categoryName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeProvider.darkTheme ? [Colors.black, Colors.black] : [Colors.indigo[300]!, Colors.indigo[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.8],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
