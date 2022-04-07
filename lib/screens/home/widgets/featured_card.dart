import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/screens/product/product.dart';

class FeaturedCard extends StatelessWidget {
  final Product product;
  const FeaturedCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductPage(product: product)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 200.0,
        width: 120.0,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/products/${product.imagePath}',
              height: 75,
            ),
            Text(
              product.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
            Text(
              product.productWeight,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            Text(
              '${product.price.toStringAsFixed(2)} zł',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
