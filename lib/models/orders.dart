class OrderCart {
  final List products;
  final List quantities;

  OrderCart({
    required this.products,
    required this.quantities,
  });
}

class Order {
  final String id;
  final String userID;
  final int status;
  final DateTime date;
  final double value;
  final OrderCart cart;

  Order({
    required this.id,
    required this.userID,
    required this.status,
    required this.date,
    required this.value,
    required this.cart,
  });
}
