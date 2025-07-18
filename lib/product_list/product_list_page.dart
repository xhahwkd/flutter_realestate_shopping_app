import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("매물 목록")),
      body: ListView(children: [Text("매물 목록 페이지입니다.")]),
    );
  }
}
