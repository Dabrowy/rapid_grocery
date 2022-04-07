import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/models/promo.dart';
import 'package:rapid_grocery/screens/category/category.dart';
import 'package:rapid_grocery/screens/product/product.dart';

int categoryIndex(Promo promo, List<Category> list) {
  int index = 0;

  for (int i = 0; i < list.length; i++) {
    if (list[i].id == promo.id) {
      index = i;
      break;
    }
  }

  return index;
}

int productIndex(Promo promo, List<Product> list) {
  int index = 0;

  for (int i = 0; i < list.length; i++) {
    if (list[i].id == promo.id) {
      index = i;
      break;
    }
  }

  return index;
}

class PromoCard extends StatelessWidget {
  final Promo promo;
  final List<Category> categories;
  final List<Product> products;

  const PromoCard({
    Key? key,
    required this.promo,
    required this.categories,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;

    if (promo.promoCategory == 1) {
      index = categoryIndex(promo, categories);
    } else {
      index = productIndex(promo, products);
    }

    return InkWell(
      onTap: promo.promoCategory == 1
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CategoryPage(category: categories[index])),
              );
            }
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProductPage(product: products[index])),
              );
            },
      child: Container(
        height: 150.0,
        width: 200.0,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset.zero,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 15,
              bottom: 15,
              child: Image.asset(
                promo.promoCategory == 1
                    ? 'assets/categoriesIcons/${promo.imagePath}'
                    : 'assets/products/${promo.imagePath}',
                height: 75.0,
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Text(
                '${promo.title},\nobniżki aż do',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '- ${promo.discount}!',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Text(
                  promo.date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
