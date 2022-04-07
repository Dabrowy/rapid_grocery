import 'package:get/get.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(Product product, int quantity) {
    if (_products.containsKey(product)) {
      _products[product] += quantity;
    } else {
      _products[product] = quantity;
    }

    if (quantity == 1) {
      Get.snackbar(
        'Produkt dodany do koszyka',
        'Dodałeś $quantity sztukę produktu',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (quantity < 5) {
      Get.snackbar(
        'Produkty dodane do koszyka',
        'Dodałeś $quantity sztuki produktu',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Produkty dodane do koszyka',
        'Dodajeś $quantity sztuk produktu',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void addProductInCart(Product product, int quantity) {
    if (_products.containsKey(product)) {
      _products[product] += quantity;
    } else {
      _products[product] = quantity;
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
      Get.snackbar(
        'Produkt został usunięty z koszyka',
        'Usunięto ${product.productName}',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } else {
      _products[product] -= 1;
    }
  }

  void removeProductWhenClearingCart(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  void removeAll() {
    List list = _products.keys.toList();
    for (int i = 0; i < list.length; i++) {
      int numOfProducts = _products[list[i]];
      for (int j = 0; j < numOfProducts; j++) {
        removeProductWhenClearingCart(list[i]);
      }
    }

    Get.snackbar(
      'Usunięto wszystkie produkty z koszyka',
      'Koszyk został wyczyszczony',
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  get products => _products;

  String total() {
    double total = 0.0;

    if (_products.isNotEmpty) {
      List list = _products.keys.toList();
      for (int i = 0; i < list.length; i++) {
        total += list[i].price * _products[list[i]];
      }
    }

    return total.toStringAsFixed(2);
  }
}
