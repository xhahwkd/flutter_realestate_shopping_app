import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/main.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_register_page.dart';
import 'package:flutter_realestate_shopping_app/product_page/widgets/product_card.dart';
import '../models/product_model.dart';

class ProductListPage extends StatefulWidget {
  final List<Product>? productList; //필터링된 매물 리스트 전달용
  final bool isSeller; //판매자인지 여부 추가

  const ProductListPage({
    super.key,
    this.productList, //전달받은 필터링 리스트
    this.isSeller = false, //기본값은 구매자(false)
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void _addProduct(Product product) {
    setState(() {
      globalProductList.add(product); //전역 리스트에 추가
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> displayList = widget.productList ?? globalProductList;

    return Scaffold(
      appBar: AppBar(title: const Text('매물 목록')),
      body:
          displayList
              .isEmpty //필터링된 결과가 없을 경우 메시지 표시
          ? const Center(
              child: Text('매물이 존재하지 않습니다.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayList.length, //필터링된 길이만큼만 생성 (안전한리스트접근?)
              itemBuilder: (context, index) {
                return ProductCard(product: displayList[index]);
              },
            ),
      floatingActionButton:
          widget
              .isSeller //판매자일 때만 + 버튼 표시
          ? FloatingActionButton(
              onPressed: () async {
                final newProduct = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductRegisterPage(),
                  ),
                );
                if (newProduct != null && newProduct is Product) {
                  _addProduct(newProduct);
                }
              },
              child: const Icon(Icons.add),
            )
          : null, //구매자는 + 버튼 없음
    );
  }
}
