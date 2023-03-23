import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pharmadex/pages/pages.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../controllers/controllers.dart';
import '../main.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  void initState() {
    setState(() {});
    super.initState();
    Get.lazyPut(() => CartController());
  }

  void searchDataset(String query) {
    query = query.toLowerCase();
    // final products = testProducts.where((product) {
    //   final prodLabel = product.label.toLowerCase();
    //   final prodSku = product.sku.toString();
    //   final input = query;

    //   return prodLabel.contains(input) || prodSku.contains(input);
    // }).toList();

    setState(() {
      // this.products = products;
      // this.query = query;
      // isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sales'),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
              ),
              // child: const SearchField(hint: 'Find a product', text: 'Find'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Get.toNamed('/home'),
                              icon: const Icon(
                                Icons.sell_outlined,
                                size: 22,
                              ),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('New sale'),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12)),
                            ),
                            const SearchField(
                                hint: 'Find a sale', text: 'Find'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                            child: SingleChildScrollView(
                          child: saleList(),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            // Theme.of(context).colorScheme.secondary.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10)),
                        // height: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: const CartView(),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Sale>> saleList() {
    return StreamBuilder<List<Sale>>(
        stream: objectbox.getSales(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return Container(
              alignment: Alignment.topLeft,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(snapshot.data!.length, (index) {
                    var sale = snapshot.data![index];
                    return SaleTile(
                      // lines: sale.lines,
                      sale: sale,
                      id: sale.id,
                      price: sale.price,
                    );
                  })),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  // Theme.of(context).colorScheme.secondary.withOpacity(.5),
                  borderRadius: BorderRadius.circular(10)),
              // height: 100,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/public/rx-sales.png', height: 400),
                  const Text('No sales yet', style: TextStyle()),
                ],
              ),
            );
          }
        });
  }
}

          // subtitle: Column(
          //   children: [
          //     sale.lines.forEach((Line e) {
          //       InvoiceLine(
          //         product: e.product.name,
          //         quantity: e.quantity,
          //       );
          //     }),
          //   ],
          // ),