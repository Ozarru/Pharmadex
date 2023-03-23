// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../main.dart';
import 'widgets.dart';
import '../objectbox.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    this.image,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.adminship,
    this.isAdmin = false,
  }) : super(key: key);

  final String? image;
  final String firstname;
  final String lastname;
  final String role;
  final num adminship;
  final bool? isAdmin;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image!),
          radius: 50,
        ),
        title:
            Text(firstname, style: Theme.of(context).textTheme.displayMedium),
        subtitle: Text(lastname),
        // subtitle: Text(role),
        trailing: Text('Admin level: $adminship',
            style: Theme.of(context).textTheme.bodyLarge),
      );
}

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {Key? key, required this.title, required this.icon, required this.route})
      : super(key: key);

  final String title;
  final IconData icon;
  final String route;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, route),
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 22,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey.shade700,
        size: 12,
      ),
    );
  }
}

class ProdTile extends StatelessWidget {
  const ProdTile(
      {Key? key,
      required this.product,
      required this.name,
      required this.brand,
      required this.quantity,
      required this.price,
      required this.isFav})
      : super(key: key);

  final Product product;
  final String name;
  final String brand;
  final int quantity;
  final num price;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    void deleteProduct(Product product) {
      objectbox.prodBox.remove(product.id);
      debugPrint('Product ${product.name} deleted');
    }

    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext context) => productDisAdminils(
      //             product: product,
      //           )));
      // },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 100,
        width: 296,
        // constraints: const BoxConstraints(minWidth: 296, maxWidth: 360),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: AssetImage('assets/brand/pd-logo.jpg'),
                            fit: BoxFit.contain))),
                Container(
                  // padding: EdgeInsets.only(top: 8),
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                      Text(brand),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$price XOF'),
                          PopupMenuButton(
                              // focusNode:,
                              tooltip: 'more options',
                              // highlightColor:
                              //     Theme.of(context).colorScheme.secondary,
                              // onPressed: () {
                              //   cartController.addProduct(product);
                              // },
                              icon: Icon(Icons.more_horiz_rounded,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('View'),
                                          Icon(TablerIcons.eye,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                    PopupMenuItem(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Edit'),
                                            Icon(TablerIcons.edit,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ],
                                        ),
                                        onTap: () {}),
                                    PopupMenuItem(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Delete'),
                                            Icon(TablerIcons.trash,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary),
                                          ],
                                        ),
                                        onTap: () {
                                          deleteProduct(product);
                                        }),
                                  ]),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(left: 4, bottom: 2, child: FavRed()),
          ],
        ),
      ),
    );
  }
}

class POSTile extends StatelessWidget {
  POSTile(
      {Key? key,
      required this.product,
      required this.name,
      required this.brand,
      required this.quantity,
      required this.price,
      required this.isFav})
      : super(key: key);

  final Product product;
  final String name;
  final String brand;
  final int quantity;
  final num price;
  final bool isFav;

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext context) => productDisAdminils(
      //             product: product,
      //           )));
      // },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 100,
        width: 296,
        // constraints: const BoxConstraints(minHeight: 300),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: AssetImage('assets/brand/pd-logo.jpg'),
                            fit: BoxFit.contain))),
                Container(
                  // padding: EdgeInsets.only(top: 8),
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                      Text(brand),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$price XOF'),
                          IconButton(
                              // focusNode:,
                              tooltip: 'Add to cart',
                              highlightColor:
                                  Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                cartController.addProduct(product);
                              },
                              icon: Icon(TablerIcons.shopping_cart_plus,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(left: 4, bottom: 2, child: FavRed()),
          ],
        ),
      ),
    );
  }
}

class SaleTile extends StatelessWidget {
  SaleTile({
    Key? key,
    required this.id,
    required this.sale,
    required this.price,
    // required this.lines,
    this.date,
  }) : super(key: key);

  // final List<Line> lines;
  final Sale sale;
  final int id;
  final int price;
  final DateTime? date;
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    void deleteSale(Sale sale) {
      objectbox.saleBox.remove(sale.id);
      debugPrint('Sale ${sale.id} deleted');
    }

    var prod = Product;

    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext context) => productDisAdminils(
      //             product: product,
      //           )));
      // },
      child: Container(
        padding: const EdgeInsets.all(4),
        // height: 100,
        width: 200,
        // constraints: const BoxConstraints(minHeight: 300),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          leading: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                      image: AssetImage('assets/brand/pd-logo.jpg'),
                      fit: BoxFit.contain))),
          title: FittedBox(
            fit: BoxFit.contain,
            child: Text("Sale ID: $id",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text("$price XOF"),
              ),
              Column(
                children: [
                  for (Line line in sale.lines)
                    // prod = line.product as Product;
                    // Text("${line.product.name}"),
                    InvoiceLine(
                      product: line.product as Product,
                      quantity: line.quantity,
                    )
                ],
              ),
              FittedBox(
                fit: BoxFit.contain,
                // child: Text("Date"),
                child: Text(DateFormat.yMd().format(sale.date)),
              ),
            ],
          ),
          trailing: PopupMenuButton(
              // focusNode:,
              tooltip: 'more options',
              // highlightColor:
              //     Theme.of(context).colorScheme.secondary,
              // onPressed: () {
              //   cartController.addProduct(product);
              // },
              icon: Icon(
                Icons.more_horiz_rounded,
                color: Theme.of(context).colorScheme.primary.withOpacity(.7),
              ),
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('View'),
                          Icon(TablerIcons.eye,
                              color: Theme.of(context).colorScheme.primary),
                        ],
                      ),
                      onTap: () {},
                    ),
                    PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Edit'),
                            Icon(TablerIcons.edit,
                                color: Theme.of(context).colorScheme.secondary),
                          ],
                        ),
                        onTap: () {}),
                    PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delete'),
                            Icon(TablerIcons.trash,
                                color: Theme.of(context).colorScheme.tertiary),
                          ],
                        ),
                        onTap: () {
                          deleteSale(sale);
                        }),
                  ]),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({
    Key? key,
    required this.name,
    this.description,
  }) : super(key: key);

  final String name;
  final String? description;

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext context) => productDisAdminils(
      //             product: product,
      //           )));
      // },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16),
        height: 30,
        // width: 100,
        // constraints: const BoxConstraints(minHeight: 300),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                        image: AssetImage('assets/brand/pd-logo.jpg'),
                        fit: BoxFit.contain))),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class ProductLine extends StatelessWidget {
  const ProductLine(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          // width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(product.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.secondary))),
              Text('\$ ${product.price}',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Text('x $quantity',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500))
      ]),
    );
  }
}

class InvoiceLine extends StatelessWidget {
  const InvoiceLine({Key? key, required this.product, required this.quantity})
      : super(key: key);
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final total = quantity * product.price;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          // width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(product.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary))),
              Text('\$ ${product.price} $quantity',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Text('Total: $total',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500))
      ]),
    );
  }
}

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 320,
      width: 400,
      constraints: BoxConstraints(maxHeight: 320, maxWidth: 400),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(.3),
          borderRadius: BorderRadius.circular(16)),
      child: TableCalendar(
        availableGestures: AvailableGestures.all,
        headerStyle:
            HeaderStyle(formatButtonVisible: false, titleCentered: true),
        rowHeight: 40,
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2050, 12, 31),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
