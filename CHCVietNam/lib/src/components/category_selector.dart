import 'package:chc/src/Models/category.dart';
import 'package:chc/src/components/Values.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  CategorySelector({Key? key}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}
class _CategorySelectorState extends State<CategorySelector>{
  final List<Category> categories = StaticValues().categories;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(categories.length, (index) {
              Category category = categories[index];
              bool isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? Colors.black : Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    category.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              );
            })),
      ),
    );
  }
}