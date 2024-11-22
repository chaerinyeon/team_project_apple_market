// lib/providers/product_provider.dart

import 'package:flutter/foundation.dart';

import 'product.dart';

class ProductProvider with ChangeNotifier {
  int _currentID = 1;
  List<Product> _products = [
    Product(
        id: 10000000,
        name: '아이폰',
        price: 120,
        brand: PhoneBrand.iPhone,
        imageUrl: 'www.samsung.com'),
    Product(
        id: 200000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl: 'www.samsung.com'),
    Product(
        id: 300000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl: 'www.samsung.com'),
    Product(
        id: 40000000,
        name: '삼성폴더폰',
        price: 12,
        brand: PhoneBrand.Samsung,
        imageUrl: 'www.samsung.com')
  ];

  final List<Product> _favoriteProducts = []; 
  List<Product> get products => _products;
  List<Product> get favoriteProducts => _favoriteProducts;

  void setProducts(List<Product> products) {
    _products = products;
    if (_products.isEmpty) {
      _currentID =
          _products.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    } else {
      _currentID = 1;
    }
    notifyListeners();
  }

  void addProduct({
    required String name,
    required int price,
    required String imageUrl,
    required PhoneBrand brand,
  }) {
    final newProduct = Product(
      id: _currentID,
      name: name,
      price: price,
      imageUrl: imageUrl,
      brand: brand,
    );
    _products.add(newProduct);
    _currentID++;
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
      notifyListeners();
    }
  }
}
