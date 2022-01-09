import 'package:flutter/material.dart';

class DocCard extends StatelessWidget {
  final String title;
  final String detail;
  final funtion;
  const DocCard({
    Key? key,
    required this.title,
    required this.detail,
    required this.funtion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 5,),
                Text("a", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}