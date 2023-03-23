import 'package:objectbox/objectbox.dart';

@Entity()
class Product {
  @Id()
  int id;
  String name;
  String brand;
  int quantity;
  int price;
  int? cost;
  bool isfav;
  String? description;
  String? dosage;
  String? ailments;
  String? alternatives;
  int? pallets;
  int? cartons;
  int? boxes;
  int? units;
  int? tabs;

  @Property(type: PropertyType.date)
  DateTime? prodDate;
  DateTime? expDate;

// do not forget to add alternatives to drugs
  Product(
    this.name,
    this.brand,
    this.quantity,
    this.price, {
    this.id = 0,
    this.isfav = false,
    this.cost = 0,
    this.description,
    this.dosage,
    this.ailments,
    this.alternatives,
    this.pallets,
    this.cartons,
    this.boxes,
    this.units,
    this.tabs,
    this.prodDate,
    this.expDate,
  });

  final category = ToOne<Category>();
  @Backlink('product')
  final lines = ToMany<Line>();
}

@Entity()
class Category {
  @Id()
  int id;
  String name;
  String? description;
  Category(this.name, {this.id = 0, this.description});
}

@Entity()
class Line {
  @Id()
  int id;
  int quantity;
  int price;
  int total;

  Line(this.quantity, this.price, this.total, {this.id = 0});
  final product = ToOne<Product>();
  final sale = ToOne<Sale>();
}

@Entity()
class Sale {
  @Id()
  int id;
  int price;

  @Property(type: PropertyType.date)
  DateTime date;

  Sale(this.price, this.date, {this.id = 0});

  @Backlink('sale')
  final lines = ToMany<Line>();
}
