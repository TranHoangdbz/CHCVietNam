import 'package:cloud_firestore/cloud_firestore.dart';

class DocsFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Docs");
}