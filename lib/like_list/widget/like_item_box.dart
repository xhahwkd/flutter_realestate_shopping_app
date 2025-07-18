import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/check_box.dart';

class LikeItemBox extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Container(
      child: Row(
        children: [
          MyCheckbox(),
          Text("이미지"),
          Column(
            children: [
              Row(children: [Text("상품 이름"), Text("닫기 버튼")]),
              Row(children: [Text("매물 유형"), Text("가격")]),
            ],
          ),
        ],
      ),
    );
  }
}
