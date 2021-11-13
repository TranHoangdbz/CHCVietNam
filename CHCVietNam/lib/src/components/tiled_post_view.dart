import 'package:chc/src/Models/Posts.dart';
import 'package:flutter/material.dart';

import 'Values.dart';

class TiledPostView extends StatelessWidget {
  TiledPostView({Key? key}) : super(key: key);
  final List<Post> posts = StaticValues().posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(posts.length, (index) {
        Post postsItem = posts[index];
        int postsDescriptionLength = postsItem.descrption.split(' ').length;
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => postsViewPage(postsPost: postsItem)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    postsItem.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Text(
                            getTruncatedTitle(postsItem.title, 60),
                          )),
                      SizedBox(
                        height: 20
                        ,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   "${postsDescriptionLength >= 200 ? (postsDescriptionLength / 200).floor() : (postsDescriptionLength / 200 * 60).floor()} ${postsDescriptionLength >= 200 ? "mins" : "secs"} read",
                          //   style: TextStyle(
                          //       fontSize: 13, color: Colors.grey[700]),
                          // ),
                          Text(
                            postsItem.time,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}