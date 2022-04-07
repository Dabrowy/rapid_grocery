import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/screens/category/category.dart';

class CategoriesCard extends StatelessWidget {
  final Category category;
  const CategoriesCard({
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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/categoriesImages/${category.imagePath}'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset.zero,
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/categoriesIcons/${category.iconPath}',
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
