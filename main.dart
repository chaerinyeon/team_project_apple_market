import 'package:apple_market/pages/add_product/add_product_page.dart';
import 'package:apple_market/pages/product_list/product/product_provider.dart';
import 'package:apple_market/pages/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Market',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ProjectListPage(),
      routes: {
        AddProductPage.routeName: (context) => const AddProductPage(),
      },
    );
  }
}
