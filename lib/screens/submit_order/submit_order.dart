import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:rapid_grocery/screens/loading/loading.dart';
import 'package:rapid_grocery/screens/submit_order/widgets/order_summary_product.dart';
import 'package:rapid_grocery/services/cart_controller.dart';
import 'package:rapid_grocery/services/database.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final CartController cartController = Get.find();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return loading == true
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Podsumowanie zamówienia'),
              backgroundColor: primaryColor,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    for (int i = 0; i < cartController.products.length; i++)
                      OrderSummaryProduct(
                          product: cartController.products.keys.toList()[i],
                          quantity: cartController.products.values.toList()[i]),
                    Text(
                      'Razem: ${cartController.total()} zł',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      height: 30.0,
                      color: Colors.grey,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        List list = cartController.products.keys.toList();
                        List ids = [];
                        for (int i = 0;
                            i < cartController.products.length;
                            i++) {
                          ids.add(list[i].id);
                        }
                        await DatabaseService(uid: user.uid).submitAnOrder(
                          double.parse(cartController.total()),
                          OrderCart(
                            products: ids,
                            quantities: cartController.products.values.toList(),
                          ),
                        );
                        cartController.removeAll();
                        setState(() => loading = false);
                        Navigator.pop(context);
                      },
                      child: const Text('Złóz zamówienie'),
                    ),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
          );
  }
}
