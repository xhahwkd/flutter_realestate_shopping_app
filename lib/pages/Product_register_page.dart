import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductRegisterPage extends StatefulWidget {
  const ProductRegisterPage({super.key});

  @override
  State<ProductRegisterPage> createState() => _ProductRegisterPageState();
}

class _ProductRegisterPageState extends State<ProductRegisterPage> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  String? imagePath;
  bool imageSelected = false;

  String formatPrice(String price) {
    if (price.isEmpty) return '';
    final number = int.tryParse(price.replaceAll(',', ''));
    if (number == null) return '';
    return number.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }

  void showImagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('이미지가 선택되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                imageSelected = true;
                imagePath = 'assets/house.png';
              });
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void trySubmit() {
    if (!imageSelected ||
        nameController.text.isEmpty ||
        typeController.text.isEmpty ||
        priceController.text.isEmpty ||
        descController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 항목을 입력해 주세요.')));
      return;
    }

    final product = Product(
      name: nameController.text,
      type: typeController.text,
      price: int.tryParse(priceController.text.replaceAll(',', '')) ?? 0,
      description: descController.text,
      imagePath: imagePath!,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('상품을 등록하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('상품 등록 완료'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, product),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품등록페이지')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: showImagePicker,
              child: Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: Text(imageSelected ? 'Image 선택됨' : 'Image 선택'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '상품 이름'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: '유형'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final formatted = formatPrice(value);
                if (formatted != value) {
                  priceController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              },
              decoration: const InputDecoration(labelText: '가격'),
            ),
            TextField(
              controller: descController,
              maxLines: null,
              decoration: const InputDecoration(labelText: '상품 설명'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: trySubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                '등록하기',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
