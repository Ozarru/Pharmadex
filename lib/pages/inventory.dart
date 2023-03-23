import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../main.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  void initState() {
    setState(() {});
    super.initState();
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
    final my_scroller = ScrollController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inventory'),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CategoryList(),
            const SizedBox(height: 20),
            Expanded(
              // child: prodList()
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchField(
                          hint: 'Find a product',
                          text: 'Find',
                          widget: Icon(
                            TablerIcons.search,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(.7),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: SingleChildScrollView(child: prodList())),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   width: 100,
                  // ),
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
                        child: ListView(
                          children: [
                            Image.asset('assets/public/rx-stock.png',
                                height: 230),
                            // Text('Quickly add new products',
                            //     style: TextStyle()),
                            const QuickAddProduct()
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Product>> prodList() {
    return StreamBuilder<List<Product>>(
        stream: objectbox.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return Wrap(
                direction: Axis.horizontal,
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.spaceBetween,
                children: List.generate(snapshot.data!.length, (index) {
                  var product = snapshot.data![index];
                  return ProdTile(
                    product: product,
                    name: product.name,
                    brand: product.brand,
                    price: product.price,
                    quantity: product.quantity,
                    isFav: product.isfav,
                  );
                }));
          } else {
            return const Center(
              child: Text('Press to Play'),
            );
          }
        });
  }
}
