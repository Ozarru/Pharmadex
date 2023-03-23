import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import '../main.dart';
import '../pages/pages.dart';
import '../widgets/widgets.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key, required this.paymentMethod}) : super(key: key);

  final String paymentMethod;
  // final Sale newSale;

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final CartController cartCtrl = Get.find();
  final TextEditingController _totalCtrl = TextEditingController();
  final TextEditingController _insurerCtrl = TextEditingController();
  final TextEditingController _perctageCtrl = TextEditingController();
  late Sale? currentSale;
  List<Sale> sales = objectbox.saleBox.getAll();

  @override
  void initState() {
    currentSale = sales[sales.length - 1];
    super.initState();
  }

  void createSale() {
    debugPrint(cartCtrl.total);
    final total = int.parse(cartCtrl.total);
    if (total != 0) {
      objectbox.addSale(total, DateTime.now());
      List<Sale> updatedSales = objectbox.saleBox.getAll();
      setState(() {
        sales = updatedSales;
        currentSale;
      });
    } else {
      Get.toNamed('/home');
    }
  }

  void createLines(Sale currentSale) {
    cartCtrl.products.keys.toList().map((e) => {
          debugPrint(e.product.name
              // e.quantity,
              // e.price,
              // e.total,
              // currentSale,
              )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Responsive.isMobile(context) == true
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ListView(children: [
                Container(
                    constraints:
                        const BoxConstraints(maxHeight: 600, minHeight: 100),
                    child: buildCartProds()),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    constraints:
                        const BoxConstraints(maxHeight: 600, minHeight: 200),
                    child: buildPayment()),
                const SizedBox(
                  height: 20,
                ),
                buildCheckoutBtn(),
                const SizedBox(
                  height: 20,
                ),
              ]),
            )
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: buildCartProds(),
                      )),
                  Spacer(),
                  Flexible(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text('Transaction details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(child: buildPayment()),
                            const SizedBox(
                              height: 30,
                            ),
                            buildCheckoutBtn(),
                          ],
                        ),
                      )),
                ],
              ),
            ),
    );
  }

  Widget buildCartProds() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text('Products sold',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
              itemCount: cartCtrl.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductLine(
                  controller: cartCtrl,
                  product: cartCtrl.products.keys.toList()[index],
                  quantity: cartCtrl.products.values.toList()[index],
                  index: index,
                );
              }),
        ),
      ],
    );
  }

  Widget buildPayment() {
    final amountDue = num.parse(cartCtrl.total);
    late var amountPayed = num.parse(_totalCtrl.text);
    late var balance = amountPayed - amountDue;
    if (widget.paymentMethod == 'cash') {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Means of payment:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(widget.paymentMethod,
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of products:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.prodCount}',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total price:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.total} XOF',
                    style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
            NumInputField(
              title: 'Amount payed',
              hint: 'Amount payed by client',
              controller: _totalCtrl,
              widget: const Icon(TablerIcons.coin),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Balance due:',
                    style: Theme.of(context).textTheme.bodyLarge),
                // balance == null
                //     ? Text(
                //         //  'people dont like good things',
                //         '',
                //         style: Theme.of(context).textTheme.displaySmall)
                //     : Text(
                //         //  'people dont like good things',
                //         '$',
                //         style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
          ],
        ),
      );
    } else if (widget.paymentMethod == 'card') {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Means of payment:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(widget.paymentMethod,
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of products:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.prodCount}',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total price:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.total} XOF',
                    style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ],
        ),
      );
    } else if (widget.paymentMethod == 'insurance') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            // height: 300,
            width: 300,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Means of payment:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(widget.paymentMethod,
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Number of products:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('${cartCtrl.prodCount}',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total price:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('${cartCtrl.total} XOF',
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
                TextInputField(
                  title: 'Insurance',
                  hint: 'Name of Insurer',
                  controller: _insurerCtrl,
                  widget: const Icon(TablerIcons.building_bank),
                ),
                NumInputField(
                  title: 'Percentage',
                  hint: 'Percentage of Insurance',
                  controller: _perctageCtrl,
                  widget: const Icon(TablerIcons.percentage),
                ),
                NumInputField(
                  title: 'Amount payed',
                  hint: 'Amount payed by client',
                  controller: _totalCtrl,
                  widget: const Icon(TablerIcons.coin),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total covered by insurer:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    // balance == null
                    //     ? Text(
                    //         //  'people dont like good things',
                    //         '$0',
                    //         style: Theme.of(context).textTheme.displaySmall)
                    //     : Text(
                    //         //  'people dont like good things',
                    //         '$',
                    //         style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Balance due:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    // balance == null
                    //     ? Text(
                    //         //  'people dont like good things',
                    //         '$0',
                    //         style: Theme.of(context).textTheme.displaySmall)
                    //     : Text(
                    //         //  'people dont like good things',
                    //         '$',
                    //         style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Means of payment:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(widget.paymentMethod,
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of products:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.prodCount}',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total price:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${cartCtrl.total} XOF',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget buildCheckoutBtn() {
    return ElevatedButton.icon(
      onPressed: () async {
        // createSale();
        createLines(currentSale!);
        cartCtrl.clearCart();
        // Get.toNamed('/home');
      },
      icon: const Icon(
        TablerIcons.receipt,
        size: 22,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Checkout'),
      ),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
    );
  }

  // static Future openFile(File file) async {
  //   final url = file.path;
  //   await OpenFile.open(url);
  // }
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
                              color: Theme.of(context).colorScheme.primary))),
              Text('${product.price} XOF',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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
