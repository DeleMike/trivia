import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final int categoryTag;

  CategoryItem({
    @required this.categoryName,
    @required this.categoryTag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            colors: [Colors.indigo[300], Colors.indigo[900]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.8],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
