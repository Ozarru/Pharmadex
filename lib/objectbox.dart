import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:pharmadex/main.dart';

import 'models/models.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Product> prodBox;
  late final Box<Category> catBox;
  late final Box<Line> lineBox;
  late final Box<Sale> saleBox;

  ObjectBox._create(this.store) {
    prodBox = Box<Product>(store);
    catBox = Box<Category>(store);
    lineBox = Box<Line>(store);
    saleBox = Box<Sale>(store);

    if (prodBox.isEmpty()) {
      _putDemoData();
    }

    if (saleBox.isEmpty()) {
      addSale(0, DateTime.now());
    }
  }

  void _putDemoData() {
    Category cat1 = Category('Vitamines');
    Category cat2 = Category('Antipaludéens');

    Product prod3 = Product('CA C-1000 2327mg', 'Sandoz', 200, 2250);
    prod3.category.target = cat1;

    Product prod4 = Product('Co-Arinate 725mg', 'Dafra Pharma', 500, 1105);
    prod4.category.target = cat2;

    prodBox.putMany([prod3, prod4]);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void addProduct(
    String name,
    String brand,
    int quantity,
    int price,
    Category category, [
    int? cost,
    bool? isfav,
    String? description,
    String? dosage,
    String? ailments,
    String? alternatives,
    int? pallets,
    int? cartons,
    int? boxes,
    int? units,
    int? tabs,
    DateTime? expDate,
    DateTime? prodDate,
  ]) {
    Product newProduct = Product(name, brand, quantity, price, cost: cost
        // isfav: isfav,
        // description: description,
        // dosage: dosage,
        // ailments: ailments,
        // alternatives: alternatives,
        // pallets: pallets,
        // cartons: cartons,
        // boxes: boxes,
        // units: units,
        // tabs: tabs,
        // expDate: expDate,
        // prodDate: prodDate,
        );
    newProduct.category.target = category;

    prodBox.put(newProduct);
    debugPrint(
        'Added new product: ${newProduct.name} into the Category: ${newProduct.category.target?.name} in thw database');
  }

  void addCategory(String name, [String? description]) {
    Category newCategory = Category(name, description: description);

    catBox.put(newCategory);
    debugPrint('Added new category: ${newCategory.name} into the database');
  }

  void addLine(Product product, int quantity, int price, int total, Sale sale) {
    Line newLine = Line(quantity, price, total);

    lineBox.put(newLine);
    debugPrint('Added new line with ID : ${newLine.id} into the database');
  }

  void addSale(int price, DateTime date) {
    Sale newSale = Sale(price, date);

    saleBox.put(newSale);
    debugPrint('Added new sale with ID : ${newSale.id} into the database');
  }

  // int addCategory(String newCategory) {
  //   Category catToAdd = Category(newCategory);
  //   int newObjectId = catBox.put(catToAdd);

  //   return newObjectId;
  // }

  Stream<List<Product>> getProducts() {
    final builder = prodBox.query()
      ..order(Product_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Category>> getCategories() {
    final builder = catBox.query()
      ..order(Category_.name, flags: Order.unsigned);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Line>> getLinesOfSale(
    int saleId,
    // int prodId,
  ) {
    final builder = lineBox.query();
    builder.link(Line_.sale, Sale_.id.equals(saleId));
    // builder.link(Line_.product, Product_.id.equals(prodId));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Sale>> getSales() {
    final builder = saleBox.query()..order(Sale_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  void deleteProduct(Product product) {
    objectbox.prodBox.remove(product.id);
    debugPrint('Product ${product.name} deleted');
  }
}
