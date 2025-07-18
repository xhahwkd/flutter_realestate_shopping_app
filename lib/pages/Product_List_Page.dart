import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/pages/Product_register_page.dart';
import 'package:flutter_realestate_shopping_app/widgets/Product_card.dart';
import '../models/product_model.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> productList;
  final Function(Product)? onProductAdded;

  const ProductListPage({
    super.key,
    required this.productList,
    this.onProductAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('매물 목록')),
      body: productList.isEmpty
          ? const Center(
              child: Text('매물이 존재하지 않습니다.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductCard(product: productList[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductRegisterPage()),
          );
          if (newProduct != null &&
              newProduct is Product &&
              onProductAdded != null) {
            onProductAdded!(newProduct); // 새 상품 리스트에 추가
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
