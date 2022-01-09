import 'package:chc/src/firebase/HistoricEvent.dart';
import 'package:chc/src/firebase/lunarevent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lunar_calendar/lunar_calendar.dart';

class HistoricEventPage extends StatefulWidget{
  const HistoricEventPage({Key? key}) : super(key: key);

  @override
  _HistoricEventPageState createState() =>_HistoricEventPageState();


}

class _HistoricEventPageState extends State<HistoricEventPage>{

  HistoricFB historicFB = new HistoricFB();
  LunarEventFB lunarEventFB = new LunarEventFB();
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int year = DateTime.now().year;
  bool _hasevent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();

  }

  @override
  Widget build(BuildContext context) {
    //LoadData();
    List<int> lunarmonth = CalendarConverter.solarToLunar(year, month, day, Timezone.Vietnamese);
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/giaycoi (2).png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            //padding: EdgeInsets.all(16),
            // child: Column(
            //   children: [
            //     SizedBox(height: 120,),
            //     _hasevent == false ? Container(
            //         alignment: Alignment.centerLeft,
            //         height: 500,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: ExactAssetImage(
            //               'assets/images/giaycoi.png'
            //             ),
            //             fit: BoxFit.fill
            //           ),
            //           color: Colors.blueGrey.withOpacity(0.1),
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //         padding: EdgeInsets.only(left: 48),
            //         //padding: EdgeInsets.all(16),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(height: 60,),
            //             Text(
            //                 "Không có sự kiện nổi bật",
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                 ),
            //             ),
            //           ],
            //         ),
            //     ) : Container(
            //       alignment: Alignment.centerLeft,
            //       height: 500,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: ExactAssetImage(
            //
            //                   'assets/images/giaycoi.png'
            //               ),
            //               fit: BoxFit.fill
            //           ),
            //           color: Colors.blueGrey.withOpacity(0.1),
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //       ),
            //       padding: EdgeInsets.only(left: 48,right: 48),
            //       child: Column(
            //         children: [
            //           SizedBox(height: 120,),
            //           Container(
            //             child: Text(day + "/" + month,
            //               style: TextStyle(
            //                 fontSize: 20,
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            child: StreamBuilder(
              stream: historicFB.collectionReference.where("month" ,isEqualTo: month.toString()).where("day", isEqualTo: day.toString()).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    print("??? null");
                    return Container(
                      child: Column(
                        children: [

                        ],
                      ),
                    );
                  }else{
                    print("???");
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    return  Container(
                      //padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              alignment: Alignment.center,
                              height: 800,
                              // decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //               image: ExactAssetImage(
                              //                 'assets/images/giaycoi.png'
                              //               ),
                              //               fit: BoxFit.fill
                              //             ),
                              //             //color: Colors.blueGrey.withOpacity(0.1),
                              //             borderRadius: BorderRadius.all(Radius.circular(10))
                              //           ),
                              padding: EdgeInsets.all(32),
                              //padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30,),
                                  Text("Ngày "+ x["day"] + "/" + x["month"],
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontFamily: 'Arima',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3
                                    ),),
                                  SizedBox(height: 10,),
                                  x["title"] == "" ? Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Không có sự kiện nổi bật",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Arima',
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : Container(
                                    child: Column(
                                      children: [
                                        Text(
                                            x["title"] +"("+day.toString()+"/"+month.toString()+"/"+x["year"]+")",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Arima',
                                              fontWeight: FontWeight.w600
                                            ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          x["detail"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'RobotoSlab',
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    lunarmonth[0].toString()+"/"+lunarmonth[1].toString()+" âm lịch",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontFamily: 'Arima',
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  StreamBuilder(
                                      stream: lunarEventFB.collectionReference.where("month" ,isEqualTo: lunarmonth[1].toString()).where("day", isEqualTo: lunarmonth[0].toString()).snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (!snapshot.hasData) {
                                      print("??? null");
                                      return Container(
                                        child: Column(
                                        children: [

                                            ],
                                          ),
                                        );
                                        }else{
                                        QueryDocumentSnapshot y = snapshot.data!.docs[0];
                                          return y["event"] == "" ? Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Không có sự kiện nổi bật",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Arima',
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  y["event"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Arima',
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                Text(
                                                  y["detail"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'RobotoSlab',
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                        }
                                      }
                                  )
                                ],
                              ),
                            ),
                          ],
                      ),
                    );
                  }
                }
            )
          ),
        ),
    );
  }

  Future<void> LoadData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("HistoricEvents").where("day", isEqualTo: day).get();
    if(querySnapshot.docs.length==0) {
      _hasevent = false;
      print("ok");
    }
    else{
      _hasevent = true;
      print("oh hell no");
    }
  }

}