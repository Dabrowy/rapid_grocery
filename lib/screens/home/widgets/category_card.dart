import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/screens/category/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  CategoryPage(category: category)),
        );
      },
      child: Container(
        height: 75.0,
        width: 160.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset('assets/categoriesIcons/${category.iconPath}',
                  height: 50.0),
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 12.0,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
