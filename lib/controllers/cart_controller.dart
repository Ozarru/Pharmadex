// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  void removeLine(RxMap<dynamic, dynamic> products) {
    while (products.isNotEmpty) {
      products.forEach((key, value) => _products.remove(key));
      debugPrint('cart cleared');
    }
  }

  void clearCart() {
    _products.clear();
  }

  final _tax = 18.0;

  get products => _products;

  get tax => _tax;

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(0);

  get prodCount => _products.entries
      .map((product) => product.value)
      .toList()
      .reduce((value, element) => value + element);

  get prodsCount => _products.length;
}
