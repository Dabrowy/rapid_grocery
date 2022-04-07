import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:rapid_grocery/screens/orders/widgets/orders_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = Provider.of<List<Order>>(context);
    final user = Provider.of<MyUser>(context);
    List<Order> userOrders = [];
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].userID == user.uid) userOrders.add(orders[i]);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < userOrders.length; i++)
            OrdersCard(order: userOrders[i])
        ],
      ),
    );
  }
}
