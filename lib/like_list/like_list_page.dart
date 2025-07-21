import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/like_item_box.dart';
import 'package:flutter_realestate_shopping_app/models/like_controller.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_list_page.dart';
import 'package:get/get.dart';

class LikeListPage extends StatelessWidget {
  LikeListPage({Key? key}) : super(key: key);

  final LikeController likeController = Get.find<LikeController>();

  void _showPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("구매 확인"),
        content: Text("정말 구매하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            child: Text("취소"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: Text("확인"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop(); // 팝업 닫기
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductListPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("찜 목록")),
      body: Stack(
        children: [
          Column(
            children: [
              // 찜 목록 리스트
              Expanded(
                child: Obx(() {
                  final likeList = likeController.likedProducts;
                  if (likeList.isEmpty) {
                    return const Center(child: Text('찜한 상품이 없습니다.'));
                  }
                  return ListView.builder(
                    itemCount: likeList.length,
                    itemBuilder: (context, index) {
                      final product = likeList[index];
                      return LikeItemBox(product: product);
                    },
                  );
                }),
              ),
              // 하단 구매하기 버튼
              Padding(
                padding: const EdgeInsets.all(30),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(191, 49, 49, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          onPressed: likeController.hasChecked
                              ? () => _showPurchaseDialog(context)
                              : null, // 체크 없으면 비활성화
                          child: const Text(
                            "구매하기",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 오른쪽 하단에 선택한 매물 가격의 총계 계산
          Positioned(
            right: 15,
            bottom: 100, // 구매 버튼 위에 위치
            child: Obx(() {
              final total = likeController.checkedTotalPrice;
              return total > 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      child: Text(
                        "총계: " + _formatPrice(total),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(191, 49, 49, 1.0),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }

  // 3자리마다 쉼표 함수
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        ) +
        '원';
  }
}
