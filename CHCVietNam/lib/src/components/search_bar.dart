import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget{
  const SearchBar({Key?  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Tìm kiếm"),
      body: Container(
        child: TextField(
          style: TextStyle(fontSize: 18 ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            hintText: "Tìm kiếm",
            filled: true,
            fillColor: Colors.grey[200]
          ),
        ),
      ),
    );
  }


}