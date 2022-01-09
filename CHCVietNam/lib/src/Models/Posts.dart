import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String title;
  String detail;
  String image;
  String id;
  String time;
  String category;

  Post(
    {
      required this.title,
      required this.detail,
      required this.image,
      required this.id,
      required this.time,
      required this.category
    }
  );

  factory Post.fromDocument(DocumentSnapshot doc){
    return Post(title: doc['title'], image: doc['image'], detail: doc['detail'], id: doc['id'], time: doc['time'],category: doc['category']);
  }

}