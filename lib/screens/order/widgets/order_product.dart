import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/models/product.dart';

class OrderProductInfoCard extends StatelessWidget {
  final String product;
  final int quantity;
  const OrderProductInfoCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<List<Product>>(context);
    int index = products.indexWhere((element) => element.id == product);

    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/products/${products[index].imagePath}',
                  height: 80.0,
                  width: 80.0,
                ),
                SizedBox(
                  width: 180.0,
                  child: Text(
                    '${products[index].productName}\n${products[index].productWeight}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
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
                      '${(quantity * products[index].price).toStringAsFixed(2)} zł',
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
            height: 20.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
