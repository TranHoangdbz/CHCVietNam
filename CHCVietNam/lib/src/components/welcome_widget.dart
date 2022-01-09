import 'package:chc/src/colors/colors.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget{
  const WelcomeWidget({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("MY VIETNAM",
              style: TextStyle(fontSize: 28,fontFamily: 'Arima',fontWeight: FontWeight.bold,color: myGrey),),
              //SizedBox(height: 5,),
              Text("Cùng khám phá văn hóa, lịch sử Việt Nam",
              style: TextStyle(
                fontSize: 16
              ),)
            ],
          ),
        ],
      ),
    );
  }
  
  
}