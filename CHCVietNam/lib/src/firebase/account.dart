import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("account");

  Future<void> add(String id,String uid,String email) async {
    //String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("account").doc(uid).set({
      "idUser" : id,
      "uid" : uid,
      "email" : email
    }
    ).then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
}