import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:chc/src/Models/Posts.dart';
import 'package:chc/src/Pages/DocsPage.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/components/welcome_widget.dart';
import 'package:chc/src/firebase/Docs.dart';
import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({Key?  key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();

}



class _SearchPageState extends State<SearchPage>{

  List<Post> listPost = [];

  TextEditingController _searchTextController = new TextEditingController();
  DocsFB docsFB = new DocsFB();

  bool filt(Post temp){
    if(temp.title.toLowerCase().contains(_searchTextController.text) || temp.detail.contains(_searchTextController.text))
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  _SearchField(),
                  SizedBox(height: 20,),
                  Container(
                    child: StreamBuilder(
                        stream: docsFB.collectionReference.snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: Text("No Data"));
                          } else {
                            listPost.clear();
                            snapshot.data!.docs.forEach((element) {
                              Post temp =Post.fromDocument(element);
                              if(filt(temp))
                                listPost.add(temp);
                            });
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listPost.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                  Post post = Post.fromDocument(x);
                                  return Container(
                                    // decoration: BoxDecoration(
                                    //     color: Colors.blueGrey.withOpacity(0.1),
                                    //     borderRadius: BorderRadius.all(Radius.circular(10))
                                    // ),
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: GestureDetector(
                                      onTap:() {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => DocsPage(post: listPost[i])));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey.withOpacity(0.1),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: Image.network(
                                                listPost[i].image,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      child: Text(
                                                        listPost[i].title,
                                                        style: TextStyle(
                                                          fontWeight:FontWeight.w400,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        " ",
                                                        style: TextStyle(
                                                            fontSize: 13, color: Colors.grey[700]),
                                                      ),
                                                      Text(
                                                        listPost[i].time,
                                                        style: TextStyle(
                                                            fontSize: 13, color: Colors.grey[700]),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                        }
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );

  }

  _SearchField() => Container(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.blueGrey.withOpacity(0.1)
    ),
    child: TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      controller: _searchTextController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nhập nội dung tìm kiếm"
      ),
      keyboardType: TextInputType.name,
      //obscureText: true,
      onChanged: (value) {
        setState(() {});
      },

    ),
  );

}