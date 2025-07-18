import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> categories;
  final void Function(String) onCategorySelected;
  final String filteringCategory;

  const CategoryDropdown({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    required this.filteringCategory,
  }) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory; // null 허용

  @override
  void initState() {
    super.initState();
    _selectedCategory = null; // 아무것도 선택하지 않은 상태로 시작
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            hint: Center(child: Text(widget.filteringCategory)),
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down_circle_rounded,
              color: Color.fromRGBO(191, 49, 49, 1.0),
              size: 50,
            ),
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue;
                });
                widget.onCategorySelected(newValue);
              }
            },
            items: widget.categories.map<DropdownMenuItem<String>>((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(value, style: TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
