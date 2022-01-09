import 'package:cloud_firestore/cloud_firestore.dart';

class LunarEventFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("lunarevent");
}