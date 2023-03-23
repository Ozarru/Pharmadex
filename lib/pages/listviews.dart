import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../main.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
    return StreamBuilder<List<Product>>(
        stream: objectbox.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUtilityBar(),
                  const SizedBox(height: 20),
                  Expanded(
                    // color: Colors.grey[200],
                    // padding: EdgeInsets.all(16),
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 16,
                        runSpacing: 16,
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
                        })),
                  ),
                ],
              ),
            );
          } else {
            return _addProdBtn();
          }
        });
  }

  Widget buildUtilityBar() {
    if (Responsive.isMobile(context)) {
      return SearchField(
        hint: 'Find a product',
        text: 'Find',
        widget: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter,
              color: Theme.of(context).colorScheme.secondary,
            )),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _addProdBtn(),
          const SearchField(hint: 'Find a product', text: 'Find'),
        ],
      );
    }
  }

  ElevatedButton _addProdBtn() {
    return ElevatedButton.icon(
      onPressed: () => Get.toNamed('/add-product'),
      icon: const Icon(
        TablerIcons.box,
        size: 22,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Add new'),
      ),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
    );
  }
}

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _xscroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: objectbox.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return Scrollbar(
              controller: _xscroller,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.secondary.withOpacity(.5),
                    borderRadius: BorderRadius.circular(16)),
                child: ListView(
                    controller: _xscroller,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(snapshot.data!.length, (index) {
                      var category = snapshot.data![index];
                      return CategoryTile(
                        name: category.name,
                        description: category.description,
                      );
                    })),
              ),
            );
          } else {
            return ElevatedButton.icon(
              onPressed: () => Get.toNamed('/add-product'),
              icon: const Icon(
                Icons.category,
                size: 22,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Add new category'),
              ),
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
            );
          }
        });
  }
}

class SaleList extends StatefulWidget {
  const SaleList({super.key});

  @override
  State<SaleList> createState() => _SaleListState();
}

class _SaleListState extends State<SaleList> {
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
    return StreamBuilder<List<Sale>>(
        stream: objectbox.getSales(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildUtilityBar(),
                const SizedBox(height: 20),
                Expanded(
                  // color: Colors.grey[200],
                  // padding: EdgeInsets.all(16),
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(snapshot.data!.length, (index) {
                        var sale = snapshot.data![index];
                        return SaleTile(
                          sale: sale,
                          id: sale.id,
                          price: sale.price,
                        );
                      })),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Add a new sale'),
            );
          }
        });
  }

  Widget buildUtilityBar() {
    if (Responsive.isMobile(context)) {
      return SearchField(
        hint: 'Find a sale',
        text: 'Find',
        widget: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter,
              color: Theme.of(context).colorScheme.secondary,
            )),
      );
    } else {
      return Row(
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
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
          ),
          const SearchField(hint: 'Find a sale', text: 'Find'),
        ],
      );
    }
  }
}
