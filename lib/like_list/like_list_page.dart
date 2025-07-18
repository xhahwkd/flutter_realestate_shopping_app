import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/like_item_box.dart';
import 'package:flutter_realestate_shopping_app/product_list/product_list_page.dart';

class LikeListPage extends StatelessWidget {
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(10, (index) => LikeItemBox()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
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
                    onPressed: () {
                      _showPurchaseDialog(context);
                    },
                    child: Text(
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
        ],
      ),
    );
  }
}
