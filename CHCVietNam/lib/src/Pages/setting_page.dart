import 'dart:io';

import 'package:chc/src/Pages/app_info_page.dart';
import 'package:chc/src/Pages/change_password_page.dart';
import 'package:chc/src/Pages/change_profile_page.dart';
import 'package:chc/src/Pages/login_page.dart';
import 'package:chc/src/firebase/Docs.dart';
import 'package:chc/src/firebase/Profile.dart';
import 'package:chc/src/widgets/cards/DocCard.dart';
import 'package:chc/src/widgets/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget{

  const SettingPage({ Key ? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

  //late final String uid;
  ProfileFB profileFB = new ProfileFB();
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  File? file;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //uid = auth.currentUser!.uid;
  //   FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get().then((value) => {
  //     print(value["idUser"]),
  //     uid = value["idUser"]
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
            padding: EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: profileFB.collectionReference.where('uid', isEqualTo: uid).snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"),);
                    } else {
                      QueryDocumentSnapshot x = snapshot.data!.docs[0];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //_title("Phần mềm"),
                          SizedBox(height: 80,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _selectImage();
                                    },
                                    child: file == null && x['image'] == ""
                                        ? Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.withOpacity(0.8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80))
                                      ),
                                    )
                                        : file == null ? Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80))
                                      ),
                                      child: ClipRRect(
                                        child: Image.network(x['image'],
                                          //width: 160,
                                          height: 160,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                    ) : Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80))
                                      ),
                                      child: ClipRRect(
                                        child: Image.file(file!,
                                          width: 160,
                                          height: 160,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    x['name'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 30,),

                          _tab_detail("Thông tin", () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AppInfoPage(uid: uid)));
                          }),

                          SizedBox(height: 10,),

                          _tab_detail("Tùy chỉnh", () {}),

                          SizedBox(height: 30,),

                          //_title("Tài khoản"),

                          SizedBox(height: 10,),

                          _tab_detail("Thay đổi thông tin", () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeProfilePage(uid: uid)));
                          }),

                          SizedBox(height: 10,),

                          _tab_detail("Đổi mật khẩu", () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePassWordPage()));
                          }),

                          SizedBox(height: 10,),

                          _tab_logout("Đăng xuất", () {
                            _logout();
                          }),
                        ],
                      );
                    }
                  }
              ),
          )
        )
    );
  }

  _tab_detail(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(16),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.blueGrey.withOpacity(0.1)
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );

  _tab_logout(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(16),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.pink.withOpacity(0.05)
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  void _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));

  }

}

