import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_grocery/screens/cart/widgets/cart_order.dart';
import 'package:rapid_grocery/screens/cart/widgets/cart_product_card.dart';
import 'package:rapid_grocery/screens/cart/widgets/cart_total.dart';
import 'package:rapid_grocery/services/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            if (cartController.products.length == 0)
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Twój koszyk jest pusty',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            for (int i = 0; i < cartController.products.length; i++)
              CartProductCard(
                product: cartController.products.keys.toList()[i],
                quantity: cartController.products.values.toList()[i],
              ),
            const Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            Total(),
            CartButtons(),
          ],
        ),
      ),
    );
  }
}
