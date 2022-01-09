import 'package:chc/src/firebase/HistoricEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HictoricView extends StatelessWidget{

  late final String can;
  // const HictoricView({
  //   required this.can, Key? key
  // }) : super(key: key);

  HistoricFB historicFB = new HistoricFB();
  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: historicFB.collectionReference.where("month" ,isEqualTo: month).where("day", isEqualTo: day).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) {
                print("??? đéo load đc");
                return Center(child: Text("none"),);
              }else{
                print("wtf sao nó lại vô else");
                QueryDocumentSnapshot x = snapshot.data!.docs[0];
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 120,),
                        Container(
                          alignment: Alignment.center,
                          height: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/giaycoi.png'
                                ),
                                fit: BoxFit.fill
                              ),
                              color: Colors.blueGrey.withOpacity(0.1),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.all(16),
                          //padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                  x["title"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  ),
                );
              }
            }
      ),
    );
  }


}