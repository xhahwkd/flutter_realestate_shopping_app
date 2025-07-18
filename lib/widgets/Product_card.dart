import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //숫자 포맷 패키지
import 'package:flutter_realestate_shopping_app/pages/Product_Detail_Page.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 가격 포맷팅 추가
    final formattedPrice = NumberFormat('#,###').format(product.price);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 이미지 대체 텍스트 박스
              Container(
                width: 100,
                height: 80,
                color: Colors.white,
                alignment: Alignment.center, // 텍스트 가운데 정렬
                child: Text(
                  product.imagePath,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 16),
              // 상품 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('매물 종류: ${product.type}'),
                    const SizedBox(height: 4),
                    Text('가격: $formattedPrice원'),
                    const SizedBox(height: 4),
                    Text(
                      product.description, // 상품설명: 한 줄 요약 + 말 줄임 처리
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
