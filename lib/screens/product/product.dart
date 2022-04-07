import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/services/cart_controller.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final cartController = Get.put(CartController());
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    final List<String> weight = widget.product.productWeight.split(' ');
    double price = 0.0;
    late String text;
    if (weight[1] == 'g') {
      price = (widget.product.price * 1000) / int.parse(weight[0]);
      text = '${price.toStringAsFixed(2)} zł/kg';
    } else if (weight[1] == 'ml') {
      price = (widget.product.price * 1000) / int.parse(weight[0]);
      text = '${price.toStringAsFixed(2)} zł/l';
    } else if (weight[1] == 'kg') {
      price = (widget.product.price * 1) / double.parse(weight[0]);
      text = '${price.toStringAsFixed(2)} zł/kg';
    } else {
      price = (widget.product.price * 1) / double.parse(weight[0]);
      text = '${price.toStringAsFixed(2)} zł/l';
    }

    if (_quantity < 1) _quantity = 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        leading: const BackButton(color: Colors.white),
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Image.asset(
            'assets/products/${widget.product.imagePath}',
            height: 390.0,
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset.zero,
                    blurRadius: 7.5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${widget.product.productName} ${widget.product.productWeight}',
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    '${widget.product.price.toStringAsFixed(2)} zł',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: 102.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset.zero,
                          blurRadius: 7.5,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _quantity--),
                          child: const SizedBox(
                            width: 34.0,
                            child: Icon(
                              Icons.add,
                              size: 17.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 34.0,
                          child: Center(
                            child: Text('$_quantity'),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => _quantity++),
                          child: const SizedBox(
                            width: 34.0,
                            child: Icon(
                              Icons.add,
                              size: 17.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      cartController.addProduct(widget.product, _quantity);
                    },
                    child: const Text('Dodaj do koszyka'),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: const StadiumBorder(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
