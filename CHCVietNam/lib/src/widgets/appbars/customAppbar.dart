import 'package:chc/src/colors/colors.dart';
import 'package:flutter/material.dart';

customAppBar(String title) => AppBar(
  iconTheme: IconThemeData(
    color: myIndigoblue, //change your color here
  ),
  backgroundColor: Colors.white,
  elevation: 0,
  title: Text(title, style: TextStyle(color: myIndigoblue,),),
  centerTitle: true,
);