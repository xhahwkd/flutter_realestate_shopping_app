import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/like_item_box.dart';

class LikeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("찜 목록")),
      body: ListView(children: List.generate(10, (index) => LikeItemBox())),
    );
  }
}
