import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pages = {
      "Dashboard": {
        "route": "/dashboard",
        "icon": const Icon(TablerIcons.dashboard),
      },
      "Home": {
        "route": "/home",
        "icon": const Icon(TablerIcons.home_2),
      },
      "Add product": {
        "route": "/add-product",
        "icon": const Icon(TablerIcons.square_plus),
      },
      "Inventory": {
        "route": "/inventory",
        "icon": const Icon(Icons.inventory_2_outlined),
      },
      "Sales": {
        "route": "/sales",
        "icon": const Icon(Icons.sell_outlined),
      },
      "Notifications": {
        "route": "/notifications",
        "icon": const Icon(TablerIcons.bell_ringing_2),
      },
      "Stats": {
        "route": "/stats",
        "icon": const Icon(TablerIcons.chart_pie),
      },
      "Store": {
        "route": "/store",
        "icon": const Icon(Icons.store_outlined),
      },
      "Users": {
        "route": "/users",
        "icon": const Icon(Icons.people_alt_outlined),
      },
      "Settings": {
        "route": "/settings",
        "icon": const Icon(TablerIcons.settings),
      },
      "Logout": {
        "route": "/logout",
        "icon": const Icon(TablerIcons.logout),
      },
    };
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 65,
            child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Text(
                  'Pharmadex',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                )),
          ),
          ...pages.entries.map((page) => ListTile(
              leading: page.value['icon'],
              title: Text(page.key),
              onTap: () {
                Navigator.of(context).pop(context);
                Navigator.pushNamed(context, page.value['route']);
              }))
        ],
      ),
    );
  }
}
