// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class StockController extends GetxController {
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

  void clearStock(RxMap<dynamic, dynamic> products) {
    while (products.isNotEmpty) {
      products.forEach((key, value) => _products.remove(key));
      debugPrint('Stock cleared');
    }

    // for (var product in products.keys) {
    //   _products.removeWhere((key, value) => key == product);
    // }
  }

  get products => _products;

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
