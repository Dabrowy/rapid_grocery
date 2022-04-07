import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_grocery/screens/submit_order/submit_order.dart';
import 'package:rapid_grocery/services/cart_controller.dart';
import 'package:rapid_grocery/constants/colors.dart';

class CartButtons extends StatelessWidget {
  final CartController cartController = Get.find();
  CartButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDisabled = true;
    int size = cartController.products.length;

    if (size > 0) _isDisabled = false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: _isDisabled
                ? null
                : () {
                    cartController.removeAll();
                  },
            child: const Text('Wyczyść koszyk'),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: const StadiumBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: _isDisabled
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Order()),
                    );
                  },
            child: const Text('Złoz zamówienie'),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
