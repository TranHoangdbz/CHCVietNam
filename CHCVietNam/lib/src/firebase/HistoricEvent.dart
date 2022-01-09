import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricFB{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("HistoricEvents");
}