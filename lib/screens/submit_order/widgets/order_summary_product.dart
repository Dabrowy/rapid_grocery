import 'package:flutter/material.dart';
import 'package:rapid_grocery/models/product.dart';

class OrderSummaryProduct extends StatelessWidget {
  final Product product;
  final int quantity;
  const OrderSummaryProduct({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.5),
          child: Row(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Ilość',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Razem',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    '${(quantity * product.price).toStringAsFixed(2)} zł',
                    style: const TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 30.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
