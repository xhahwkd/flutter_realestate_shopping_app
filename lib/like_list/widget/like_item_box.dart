import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/check_box.dart';
import 'package:flutter_realestate_shopping_app/models/like_controller.dart';
import 'package:flutter_realestate_shopping_app/models/product_model.dart';
import 'package:get/get.dart';

class LikeItemBox extends StatelessWidget {
  final Product product;
  const LikeItemBox({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likeController = Get.find<LikeController>();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Obx(
              () => Radio<Product?>(
                value: product,
                groupValue: likeController.selectedProduct.value,
                onChanged: (Product? value) {
                  if (value != null) {
                    likeController.selectProduct(value);
                  }
                },
              ),
            ),
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child:
                  product.imagePath.endsWith('.png') ||
                      product.imagePath.endsWith('.jpg')
                  ? Image.asset(product.imagePath, fit: BoxFit.cover)
                  : Text(
                      product.imagePath,
                      style: const TextStyle(fontSize: 12),
                    ),
            ),
            const SizedBox(width: 16),
            // 매물 상세 정보 표시
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 첫 번째 줄: 상품명 + 삭제버튼
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          likeController.toggleLike(product);
                        },
                      ),
                    ],
                  ),
                  // 두 번째 줄: 매물 유형 + 가격
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.type,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        '${product.price}원',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(191, 49, 49, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
