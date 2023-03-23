import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmadex/main.dart';
import 'package:pharmadex/models/models.dart';

import '../widgets/widgets.dart';

class QuickAddProduct extends StatefulWidget {
  const QuickAddProduct({super.key});

  @override
  State<QuickAddProduct> createState() => _QuickAddProductState();
}

class _QuickAddProductState extends State<QuickAddProduct> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final catCtrl = TextEditingController();
  List<Category> categories = objectbox.catBox.getAll();
  late Category currentCategory;

  @override
  void initState() {
    currentCategory = categories[0];
    super.initState();
    setState(() {});
  }

  void updateCategory(int newCategoryID) {
    Category newCurrentCategory = objectbox.catBox.get(newCategoryID)!;
    setState(() {
      currentCategory = newCurrentCategory;
    });
  }

  void createCategory() {
    Category newCategory = Category(catCtrl.text);
    objectbox.catBox.put(newCategory);
    List<Category> newCategoryList = objectbox.catBox.getAll();
    setState(() {
      currentCategory = newCategory;
      categories = newCategoryList;
    });
  }

  void createProduct() {
    if (nameCtrl.text.isNotEmpty &&
        brandCtrl.text.isNotEmpty &&
        quantityCtrl.text.isNotEmpty &&
        priceCtrl.text.isNotEmpty) {
      objectbox.addProduct(
          nameCtrl.text,
          brandCtrl.text,
          int.parse(quantityCtrl.text),
          int.parse(priceCtrl.text),
          currentCategory);
      setState(() {
        _formKey.currentState?.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildEssentials(context),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                createProduct();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Quickly Add Products'),
              ))
        ],
      ),
    );
  }

  Widget buildEssentials(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Category *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              DropdownButton<int>(
                value: currentCategory.id,
                items: categories
                    .map((e) =>
                        DropdownMenuItem(value: e.id, child: Text(e.name)))
                    .toList(),
                onChanged: ((value) => {updateCategory(value!)}),
                underline: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          NumInputField(
            title: 'Product Name *',
            hint: 'Name',
            controller: nameCtrl,
          ),
          TextInputField(
            title: 'Product brand *',
            hint: 'Brand',
            controller: brandCtrl,
          ),
          NumInputField(
            title: 'Product quantity *',
            hint: 'Quantity',
            controller: quantityCtrl,
          ),
          NumInputField(
            title: 'Product price *',
            hint: 'Price',
            controller: priceCtrl,
          ),
        ],
      ),
    );
  }
}
