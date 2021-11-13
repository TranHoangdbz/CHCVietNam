import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget{
  const WelcomeWidget({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("MY VIETNAM",
          style: TextStyle(fontSize: 24),),
          SizedBox(height: 5,),
          Text("Cùng khám phá văn hóa, lịch sử Việt Nam")
        ],
      ),
    );
  }
  
  
}