import 'package:chc/src/Models/Posts.dart';
import 'package:chc/src/firebase/Docs.dart';
import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:chc/src/widgets/cards/DocCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocsPage extends StatefulWidget{
  final Post post;
  const DocsPage({required this.post, Key ? key}) : super(key: key);

  @override
  _DocsPageState createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage>{

  DocsFB docsFB = new DocsFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: customAppBar(""),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 4,),
                        Text(widget.post.category)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Wrap(
                runSpacing: 10,
                children: [
                  Text(
                    widget.post.title.toUpperCase(),
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Oswald',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.3
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 40,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.post.time,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  // Text(
                  //   widget.post.detail,
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400,
                  //       height: 1.8
                  //   ),
                  //   textAlign: TextAlign.justify,
                  // ),
                ],
              ),

            ),
            SizedBox(height: 20,),
            widget.post.image == ""
                ? Container()
                : _loadImage(widget.post.image),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Wrap(
                runSpacing: 10,
                children: [
                  Container(
                    child: Text(
                      widget.post.detail,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          color: Colors.black,
                          //fontWeight: FontWeight.w100,
                          height: 1.8
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),

            ),
            SizedBox(height: 10,)
          ],
        )
      ),
    );

  }
  _loadImage(String URL) => Column(
    children: [
      Image.network(
        URL,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      SizedBox(height: 10,),
    ],
  );
}