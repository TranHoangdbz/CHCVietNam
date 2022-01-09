import 'dart:io';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/firebase/Profile.dart';
import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:chc/src/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChangeProfilePage extends StatefulWidget{
  final String uid;
  const ChangeProfilePage({required this.uid, Key? key}) : super(key: key);

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();

}

class _ChangeProfilePageState extends State<ChangeProfilePage>{

  final _formkey = GlobalKey<FormState>();
  ProfileFB profileFB = new ProfileFB();
  String URL = "";

  final TextEditingController _nameController = TextEditingController();
  File? file;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Thay đổi thông tin"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child:  Form(
          key: _formkey,
          child: StreamBuilder(
              stream: profileFB.collectionReference.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"),);
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  _nameController.text = x['name'];
                  URL = x['image'];
                  return Column(
                    children: [
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
                              // SizedBox(height: 10,),
                              // Text(
                              //   x['name'],
                              //   style: TextStyle(
                              //       fontSize: 24,
                              //       fontWeight: FontWeight.w500
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                      _nameTextField(),
                      SizedBox(height: 20,),
                      MaterialButton(
                        onPressed: (){
                          if(_formkey.currentState!.validate())
                          {
                            if(file != null)
                              _change();
                            else edit();
                          }
                        },
                        height: 60,
                        minWidth: double.infinity,
                        color: myIndigoblue,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text(
                          "Thay đổi thông tin",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // SizedBox(height: 20,),
                      // _genderTextField(),
                    ],
                  );
                }
              }
          ),
        )
      ),
    );
  }

  _nameTextField() => Container(
    padding: EdgeInsets.only(left: 32, right: 32, bottom: 4, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.blueGrey.withOpacity(0.1)
    ),
    child: TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 18
      ),
      controller: _nameController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nhập tên hiển thị"
      ),
      keyboardType: TextInputType.name,
      //obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập tên hiển thị";
        }
        return null;
      },
    ),
  );

  _genderTextField() => Container(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.blueGrey.withOpacity(0.1)
    ),
    child: TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      controller: _nameController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nhập giới tính"
      ),
      keyboardType: TextInputType.name,
      //obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập giới tính";
        }
        return null;
      },
    ),
  );

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      print(path);
    });
  }

  Future _change() async{
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("news").child("post_$filename");
    LoadingDialog.showLoadingDialog(context, "Đang chỉnh sửa thông tin...");
    await ref.putFile(file!);
    URL = await ref.getDownloadURL();
    LoadingDialog.hideLoadingDialog(context);
    await edit();
  }

  Future<void> edit() async{
    profileFB.update(
        FirebaseAuth.instance.currentUser!.uid.toString(), _nameController.text,
        URL).then((value) =>
    {
      Navigator.pop(context)
    });
  }

}