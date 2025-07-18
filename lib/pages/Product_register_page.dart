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
  bool imageSelected = false; //

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
    if (nameController.text.isEmpty ||
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
      imagePath: imageSelected ? 'Image 선택됨' : 'Image 선택',
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
              Navigator.pop(context); //첫 번째 팝업 닫기
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('상품 등록 완료'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); //두 번째 팝업 닫기
                        Navigator.pop(context, product); //매물목록페이지로 이동, 상품 전달
                      },
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
                height: 210,
                color: Colors.grey[300],
                child: Center(
                  child: Text(imageSelected ? 'Image 선택됨' : 'Image 선택'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '상품 이름',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 10),

            //TextField > DropdownButtonFormField 교체
            DropdownButtonFormField<String>(
              value: typeController.text.isNotEmpty
                  ? typeController.text
                  : null,
              decoration: const InputDecoration(
                labelText: '매물 종류',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.never, //라벨 정중앙 고정
              ),
              items: ['아파트', '빌라', '오피스텔', '기타']
                  .map(
                    (type) => DropdownMenuItem(value: type, child: Text(type)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  typeController.text = value!;
                });
              },
            ),
            const SizedBox(height: 10),
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
              decoration: const InputDecoration(
                labelText: '가격',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              child: TextField(
                controller: descController,
                maxLines: null,
                expands: true, //텍스트 필드가 컨테이너를 꽉 채움
                decoration: const InputDecoration(
                  labelText: '상품 설명',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
      //등록하기 버튼 bottomNavigationBar에 고정
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 50, //등록하기 버튼 높이
          child: ElevatedButton(
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
        ),
      ),
    );
  }
}
