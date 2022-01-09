import 'package:chc/src/Models/Posts.dart';
import 'package:chc/src/Pages/DocsPage.dart';
import 'package:chc/src/firebase/Docs.dart';
import 'package:chc/src/widgets/cards/DocCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Values.dart';

class TiledPostView extends StatefulWidget {
  final String category;
  TiledPostView({required this.category, Key? key}) : super(key: key);

  @override
  _TiledPostViewState createState() => _TiledPostViewState();
}
class _TiledPostViewState extends State<TiledPostView>{

  final List<Post> posts = StaticValues().posts;
  DocsFB docsFB = new DocsFB();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
        child: StreamBuilder(
          stream: docsFB.collectionReference.where("category" ,isEqualTo: widget.category).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("No Data"));
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
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
                            Navigator.push(context,MaterialPageRoute(builder: (context) => DocsPage(post: post)));
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
                                              x['image'],
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
                                            getTruncatedTitle(x['title'], 60),
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
                                                    x['time'],
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

    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: List.generate(posts.length, (index) {
  //       Post postsItem = posts[index];
  //       int postsDescriptionLength = postsItem.descrption.split(' ').length;
  //       return GestureDetector(
  //         onTap: () {
  //           // Navigator.push(
  //           //     context,
  //           //     MaterialPageRoute(
  //           //         builder: (context) => postsViewPage(postsPost: postsItem)));
  //         },
  //         child: Container(
  //           margin: EdgeInsets.symmetric(vertical: 5),
  //           padding: EdgeInsets.all(5),
  //           decoration: BoxDecoration(
  //               color: Colors.grey[200],
  //               borderRadius: BorderRadius.circular(10)),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ClipRRect(
  //                 child: Image.network(
  //                   postsItem.image,
  //                   width: 100,
  //                   height: 100,
  //                   fit: BoxFit.cover,
  //                 ),
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                         child: Text(
  //                           getTruncatedTitle(postsItem.title, 60),
  //                         )),
  //                     SizedBox(
  //                       height: 20
  //                       ,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         // Text(
  //                         //   "${postsDescriptionLength >= 200 ? (postsDescriptionLength / 200).floor() : (postsDescriptionLength / 200 * 60).floor()} ${postsDescriptionLength >= 200 ? "mins" : "secs"} read",
  //                         //   style: TextStyle(
  //                         //       fontSize: 13, color: Colors.grey[700]),
  //                         // ),
  //                         Text(
  //                           postsItem.time,
  //                           style: TextStyle(
  //                               fontSize: 13, color: Colors.grey[700]),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}