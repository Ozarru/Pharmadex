import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../pages/pages.dart';
import 'package:tabler_icons/tabler_icons.dart';
import '../models/models.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartCtrl = Get.find();
  late ScrollController scrollCtrl;

  @override
  void initState() {
    super.initState();
    scrollCtrl = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
        child: cartCtrl.products.length == 0
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    // Theme.of(context).colorScheme.secondary.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10)),
                // height: 100,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/public/rx-shelf.png', height: 400),
                    Text('The cart is empty', style: TextStyle()),
                  ],
                ),
              )
            : buildProducts()));
  }

  Widget buildProducts() {
    return Center(
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0),
          //   child: Text('Cart',
          //       style: Theme.of(context)
          //           .textTheme
          //           .headlineSmall!
          //           .copyWith(color: Colors.indigo[900])),
          // ),
          Expanded(
            // constraints: BoxConstraints(maxHeight: 500),
            child: ListView.builder(
                controller: scrollCtrl,
                itemCount: cartCtrl.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartProductCard(
                    cartCtrl: cartCtrl,
                    product: cartCtrl.products.keys.toList()[index],
                    quantity: cartCtrl.products.values.toList()[index],
                    index: index,
                  );
                }),
          ),
          Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: SumBox()),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  const CartProductCard(
      {Key? key,
      required this.cartCtrl,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);
  final CartController cartCtrl;
  final Product product;
  final int quantity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                    image: AssetImage('assets/brand/pd-logo.jpg'),
                    fit: BoxFit.contain))),
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary))),
              Text('${product.price} XOF',
                  style: const TextStyle(fontSize: 12, color: Colors.black45))
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  cartCtrl.removeProduct(product);
                },
                icon: Icon(
                  Icons.remove_circle,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                )),
            Text('$quantity'),
            IconButton(
                onPressed: () {
                  cartCtrl.addProduct(product);
                },
                icon: Icon(
                  Icons.add_circle,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ],
        ),
      ]),
    );
  }
}

class SumBox extends StatelessWidget {
  SumBox({Key? key}) : super(key: key);

  final CartController cartCtrl = Get.find();
  final List<String> paymentMethods = ['cash', 'card', 'insurance', 'gift'];
  @override
  Widget build(BuildContext context) {
    dynamic prods = cartCtrl.products;
    if (prods.length != 0) {
      return Obx(
        () => SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.bodyLarge),
                  Text('${cartCtrl.total} XOF',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                        onPressed: () {
                          cartCtrl.clearCart();
                          // cartCtrl.removeLine(prods);
                        },
                        icon: const Text('Clear'),
                        label: const Icon(
                          Icons.backspace_sharp,
                          size: 14,
                        ),
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: 18))),
                  ),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: buildCheckout(context)),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildCheckout(context) {
    return ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
              // backgroundColor: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (builder) {
                return SizedBox(
                    width: 400,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      ListTile(
                        leading: const Icon(TablerIcons.coin),
                        title: const Text('Cash Pay'),
                        onTap: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Checkout(paymentMethod: paymentMethods[0])));
                        },
                      ),
                      ListTile(
                        leading: const Icon(TablerIcons.credit_card),
                        title: const Text('Card Pay'),
                        onTap: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Checkout(paymentMethod: paymentMethods[1])));
                        },
                      ),
                      ListTile(
                        leading: const Icon(TablerIcons.building_bank),
                        title: const Text('Insurance Pay'),
                        onTap: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Checkout(paymentMethod: paymentMethods[2])));
                        },
                      ),
                      ListTile(
                        leading: const Icon(TablerIcons.gift),
                        title: const Text('Give for free'),
                        onTap: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Checkout(paymentMethod: paymentMethods[3])));
                        },
                      ),
                    ]));
              });
        },
        icon: const Icon(
          TablerIcons.coin,
          // size: 14,
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text('Checkout'),
        ));
  }
}
