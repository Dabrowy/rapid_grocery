import 'package:flutter/material.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/screens/categories/widgets/categories_card.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < categories.length; i++)
            CategoriesCard(category: categories[i])
        ],
      ),
    );
  }
}
