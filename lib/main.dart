import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/add_products.dart';
import 'objectbox.dart';
import 'pages/home.dart';
import 'pages/pages.dart';
import 'utils/utils.dart';

late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PharmaDex',
        theme: customTheme(),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const Home(),
          '/add-product': (context) => const AddProduct(),
          '/inventory': (context) => const Inventory(),
          '/sales': (context) => const Sales(),
          '/stats': (context) => const Statistics(),
          '/notifications': (context) => const Notifications(),
          '/dashboard': (context) => const Dashboard(),
          '/cart': (context) => const CartView(),
          '/products': (context) => const ProductList(),
        });
  }
}
