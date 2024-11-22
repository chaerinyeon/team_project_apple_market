// lib/pages/product_list/project_list_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project_apple_market/pages/add_product/add_product_page.dart';
import 'package:team_project_apple_market/pages/product_list/product/product.dart';
import 'package:team_project_apple_market/pages/product_list/product/product_provider.dart';
import 'package:team_project_apple_market/pages/product_list/widgets/brand_dropdown.dart';
import 'package:team_project_apple_market/pages/product_list/widgets/product_title.dart';
import 'package:team_project_apple_market/pages/product_list/widgets/profile.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  PhoneBrand? _selectedBrand;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(
                Icons.apple,
                color: Colors.red,
              ),
              Text(
                '사과마켓',
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('장바구니 버튼 클릭됨')),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              tooltip: '장바구니',
            ),
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: '프로필',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Products',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BrandDropdown(
                selectedBrand: _selectedBrand,
                onChanged: (PhoneBrand? newBrand) {
                  setState(() {
                    _selectedBrand = newBrand;
                  });
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('No products available'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        if (_selectedBrand != null &&
                            product.brand != _selectedBrand) {
                          return const SizedBox.shrink();
                        }
                        if (_searchQuery.isNotEmpty &&
                            !product.name
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return const SizedBox.shrink();
                        }
                        return ProductTile(product: product);
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          const SizedBox(width: 1),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, AddProductPage.routeName);
            },
            backgroundColor: Colors.red,
            label: const Text('상품등록',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 30,
          )
        ]));
  }
}
