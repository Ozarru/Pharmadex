import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../controllers/controllers.dart';
import '../../pages/pages.dart';
import '../../utils/utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.icons,
  }) : super(key: key);

  final String? title;
  final List<IconButton>? icons;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        'Pharmadex',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Colors.white),
      ),
      centerTitle: false,
      actions: [
        Row(
          children: const [
            CartNotifier(),
            StoreNotifier(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class CartNotifier extends StatelessWidget {
  const CartNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find();
    return Obx(() => controller.products.length == 0
        ? builCartToggle(context)
        : Stack(children: [
            builCartToggle(context),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                alignment: Alignment.center,
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.tertiary),
                child: Text(
                  '${controller.prodsCount}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ]));
  }

  Widget builCartToggle(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.grey[200],
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              )),
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: Navigator.of(context).pop,
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.black)),
                    const SizedBox(height: 16),
                    const Flexible(
                        child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                      child: CartView(),
                    )),
                  ],
                );
              });
        },
        tooltip: 'view cart',
        icon: const Icon(TablerIcons.shopping_cart));
  }
}

class StoreNotifier extends StatelessWidget {
  const StoreNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool hasNotification = false;
    return hasNotification == false
        ? builStoreToggle(context)
        : Stack(children: [
            builStoreToggle(context),
            Positioned(
              right: 5,
              top: 10,
              child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary)),
            ),
          ]);
  }

  Widget builStoreToggle(BuildContext context) {
    return IconButton(
        onPressed: () => Get.toNamed('/notifications'),
        tooltip: 'see notifications',
        icon: const Icon(TablerIcons.bell_ringing_2));
  }
}
