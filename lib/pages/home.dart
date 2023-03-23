import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pharmadex/pages/listviews.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../controllers/controllers.dart';
import '../main.dart';
import '../utils/utils.dart';
import 'add_products.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => CartController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.5),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(height: 20),
                  const CategoryList(),
                  const SizedBox(height: 20),
                  prodList(),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Responsive.isDesktop(context) || Responsive.isWideDesktop(context)
                ? Expanded(
                    flex: 2,
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        const AppCalendar(),
                        const SizedBox(height: 20),
                        Container(
                            constraints: const BoxConstraints(
                                minHeight: 300, maxHeight: 600),
                            // height: 600,
                            child: const CartView()),
                      ],
                    ))
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const AddProduct())));
          setState(() {});
        },
        child: const Icon(Icons.add),
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
                  return POSTile(
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
