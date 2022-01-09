import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("profile");

  Future<void> add(String uid,String name, String image) async {
    //String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("profile").doc(uid).set({
      "image" : image,
      "uid" : uid,
      "name" : name
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  Future<void> update(String uid,String name, String image) async {
    //String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("profile").doc(uid).update({
      "image" : image,
      "name" : name
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }

}