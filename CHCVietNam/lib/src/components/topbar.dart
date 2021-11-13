import 'package:chc/src/components/search_bar.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget{
  const TopBar({Key?  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SearchBar()),
        SizedBox(width: 10),
        Icon(Icons.menu, size: 30)
      ],
    );
  }
}