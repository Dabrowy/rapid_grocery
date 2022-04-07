import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/services/cart_controller.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset.zero,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/products/${product.imagePath}',
            height: 80.0,
            width: 80.0,
          ),
          SizedBox(
            width: 180.0,
            child: Text(
              '${product.productName}\n${product.productWeight}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              cartController.removeProduct(product);
            },
            icon: const Icon(
              Icons.remove_circle,
              color: primaryColor,
            ),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {
              cartController.addProductInCart(product, 1);
            },
            icon: const Icon(
              Icons.add_circle,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
