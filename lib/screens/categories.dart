import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../data/category_data.dart';

class Categories extends StatelessWidget {
  static const routeName = '/categories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(15),
        children: CATEGORIES.map(
          (category) {
            return CategoryItem(
              categoryName: category.categoryName,
              categoryTag: category.categoryTag,
            );
          },
        ).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
