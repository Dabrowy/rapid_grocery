import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:rapid_grocery/screens/order/widgets/order_info.dart';
import 'package:rapid_grocery/screens/order/widgets/order_product.dart';

class OrderPage extends StatelessWidget {
  final Order order;
  final List<String> statuses;
  const OrderPage({
    Key? key,
    required this.order,
    required this.statuses,
  }) : super(key: key);

  final Widget divide = const Divider(
    color: Colors.grey,
    height: 30.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Zamówienie nr ${order.id}',
          style: const TextStyle(fontSize: 15.0),
        ),
        backgroundColor: primaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderInfo(
              status: statuses[order.status],
              date: order.date,
              numOfProducts: order.cart.products.length,
              value: order.value,
            ),
            divide,
            for (int i = 0; i < order.cart.products.length; i++)
              OrderProductInfoCard(
                product: order.cart.products[i],
                quantity: order.cart.quantities[i],
              ),
          ],
        ),
      ),
    );
  }
}
