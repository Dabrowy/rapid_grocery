import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:intl/intl.dart';
import 'package:rapid_grocery/screens/order/order.dart';

class OrdersCard extends StatelessWidget {
  final Order order;
  const OrdersCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> orderStatus = [
      'Złozone',
      'Skompletowane',
      'Wysłane',
      'Dostarczone',
    ];

    final List<IconData> iconStatus = [
      Icons.access_alarm,
      Icons.add_business,
      Icons.delivery_dining,
      Icons.assistant_direction,
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OrderPage(
                    order: order,
                    statuses: orderStatus,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          height: 200,
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
          child: Stack(
            children: [
              Positioned(
                bottom: 35,
                right: 15,
                child: Icon(
                  iconStatus[order.status],
                  size: 30,
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Zamówienie nr '),
                      TextSpan(
                        text: order.id,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 55,
                left: 15,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Status:\n',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      TextSpan(
                        text: orderStatus[order.status],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Text(
                  'Data złozenia zamówienia: ${DateFormat('yyyy-MM-dd hh:mm').format(order.date)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
