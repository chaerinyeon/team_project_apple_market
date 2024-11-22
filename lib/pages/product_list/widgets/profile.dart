// lib/pages/profile/profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:team_project_apple_market/pages/product_detail/product_detail_page.dart';
import 'package:team_project_apple_market/pages/product_list/product/product_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        Provider.of<ProductProvider>(context).favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('찜한 제품이 없습니다.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                  title: Text(product.name),
                  subtitle: Text('${product.price} 만원'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .removeFavorite(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('"${product.name}" 찜 목록에서 제거됨'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
