import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmadex/main.dart';
import 'package:pharmadex/models/models.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  final catCtrl = TextEditingController();
  final catNameCtrl = TextEditingController();
  final catDescCtrl = TextEditingController();
  // descriptives
  final prodDateCtrl = TextEditingController();
  final expDateCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final dosageCtrl = TextEditingController();
  final ailmentsCtrl = TextEditingController();
  // quantitatives
  final palletsCtrl = TextEditingController();
  final boxesCtrl = TextEditingController();
  final cartonsCtrl = TextEditingController();
  final unitsCtrl = TextEditingController();
  final tabsCtrl = TextEditingController();
  List<Category> categories = objectbox.catBox.getAll();
  late Category currentCategory;
  DateTime? today;

  @override
  void initState() {
    currentCategory = categories[0];
    super.initState();
  }

  void updateCategory(int newCategoryID) {
    Category newCurrentCategory = objectbox.catBox.get(newCategoryID)!;
    setState(() {
      currentCategory = newCurrentCategory;
    });
  }

  void createCategory() {
    if (catNameCtrl.text.isNotEmpty && catDescCtrl.text.isNotEmpty) {
      objectbox.addCategory(
        catNameCtrl.text,
        catDescCtrl.text,
      );
      List<Category> newCategoryList = objectbox.catBox.getAll();
      setState(() {
        categories = newCategoryList;
        formKey2.currentState?.reset();
      });
    }
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
        currentCategory,
        int.parse(costCtrl.text),
        // expDateCtrl
      );
      setState(() {
        formKey1.currentState?.reset();
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2040))
        .then((date) {
      setState(() {
        today = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      key: UniqueKey(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  height: 320,
                  width: MediaQuery.of(context).size.width / 1.55,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCategoryForm(context),
                      Image.asset('assets/public/rx-stock.png', height: 300),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const AppCalendar()
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.3),
                    borderRadius: BorderRadius.circular(20)),
                child: ListView(children: [
                  Form(
                    key: formKey1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildProdEssence(context),
                            buildProdQuantities(context),
                            buildProdDescription(context),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text('Add Product'),
                            ))
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProdEssence(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          title: 'Product net price *',
          hint: 'Price',
          controller: priceCtrl,
        ),
        NumInputField(
          title: 'Product net cost *',
          hint: 'Cost',
          controller: costCtrl,
        ),
        TextInputField(
          title: 'Product category',
          hint: 'Category',
          widget: DropdownButton<int>(
            value: currentCategory.id,
            items: categories
                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                .toList(),
            onChanged: ((value) => {updateCategory(value!)}),
            underline: Container(
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProdQuantities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NumInputField(
          title: 'Number of pallets',
          hint: 'Pallets',
          controller: palletsCtrl,
        ),
        NumInputField(
          title: 'Number of cartons',
          hint: 'Cartons',
          controller: cartonsCtrl,
        ),
        NumInputField(
          title: 'Number of boxes',
          hint: 'Boxes',
          controller: boxesCtrl,
        ),
        NumInputField(
          title: 'Number of units *',
          hint: 'Units',
          controller: unitsCtrl,
        ),
        NumInputField(
          title: 'Number of tabs',
          hint: 'Tabs',
          controller: tabsCtrl,
        ),
      ],
    );
  }

  Widget buildProdDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          title: 'Production date *',
          hint: 'Produced on',
          controller: expDateCtrl,
          widget: InkWell(
            onTap: _showDatePicker,
            child: Icon(
              Icons.calendar_today,
              size: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
            ),
          ),
        ),
        TextInputField(
          title: 'Expiration date *',
          hint: 'Expires on',
          controller: expDateCtrl,
          widget: InkWell(
            onTap: _showDatePicker,
            child: Icon(
              Icons.calendar_today,
              size: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
            ),
          ),
        ),
        TextAreaField(
          title: 'Product description',
          hint: 'Description',
          controller: descCtrl,
        ),
        TextAreaField(
          title: 'Product dosage',
          hint: 'Dosage',
          controller: dosageCtrl,
        ),
        TextAreaField(
          title: 'Ailments treated',
          hint: 'Ailments',
          controller: ailmentsCtrl,
        ),
      ],
    );
  }

  Widget buildCategoryForm(BuildContext context) {
    return Form(
      key: formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextInputField(
            title: 'Category Name *',
            hint: 'Name',
            controller: catNameCtrl,
          ),
          TextAreaField(
            title: 'Category description *',
            hint: 'Description',
            controller: catDescCtrl,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                createCategory();
              },
              child: const Text('Add Category'))
        ],
      ),
    );
  }
}
