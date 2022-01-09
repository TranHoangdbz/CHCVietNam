import 'package:chc/src/Models/users.dart';
import 'package:chc/src/Pages/change_password_page.dart';
import 'package:chc/src/Pages/home_page.dart';
import 'package:chc/src/Pages/register_page.dart';
import 'package:chc/src/Pages/tab_page.dart';
import 'package:chc/src/authentication/auth_bloc.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/widgets/loading.dart';
import 'package:chc/src/widgets/msg_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  late TextEditingController _emailcontroler ;
  late TextEditingController _passwordcontroler ;
  final _formkey = GlobalKey<FormState>();
  AuthBloc authBloc = new AuthBloc();


  @override
  void initState(){
    _emailcontroler = TextEditingController();
    _passwordcontroler = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _emailcontroler.dispose();
    _passwordcontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  SizedBox(height: 60,),
                  Text(
                    "Xin chào",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Vui lòng đăng nhập",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 40,),
                  _title(Icons.email, "Email"),
                  _emailTextField(),
                  SizedBox(height: 20,),
                  _title(Icons.lock, "Mật khẩu"),
                  _passwordTextField(),
                  SizedBox(height: 40,),
                  MaterialButton(
                      onPressed: (){
                        if(_formkey.currentState!.validate())
                          {
                            _login();
                          }
                      },
                    height: 60,
                    minWidth: double.infinity,
                    color: myIndigoblue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bạn chưa có tài khoản?"),
                      SizedBox(width: 5,),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      }
                      , child: Text(
                        "Đăng kí ngay",
                      ))
                    ],
                  ),
                  //SizedBox(height: 20,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TextButton(onPressed: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  //     }
                  //         , child: Text(
                  //           "Quên mật khẩu?",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: myIndigoblue,
                  //               fontWeight: FontWeight.bold
                  //           ),
                  //         )),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(){
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(_emailcontroler.text, _passwordcontroler.text, () async {
      Users users = new Users(email: _emailcontroler.text,uid: FirebaseAuth.instance.currentUser!.uid.toString());
      //ChangePassWordPageState.email = _emailcontroler.text;
      LoadingDialog.hideLoadingDialog(context);
      SharedPreferences preferences = await  SharedPreferences.getInstance();
      preferences.setString('email', _emailcontroler.text);
      FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get().then((value) => {
        print(value["idUser"]),
          Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabPage()))
      });
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage()));
  }

  _title(IconData icon, String text) => Container(
    child: Row(
      children: [
        Icon(icon, color: Colors.black,),
        SizedBox(width: 10,),
        Text(text,)
      ],
    ),
  );

  _emailTextField() => TextFormField(
    style: TextStyle(
        fontSize: 14,
        color: Colors.grey
    ),
    controller: _emailcontroler,
    //cursorColor: myGreen,
    decoration: InputDecoration(
      hintText: "Nhập email...",
      hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập email";
      }
      return null;
    },
  );
  _passwordTextField() => TextFormField(
    obscureText: true,
    style: TextStyle(
        fontSize: 14,
        color: Colors.grey
    ),
    controller: _passwordcontroler,
    decoration: InputDecoration(
      hintText: "Nhập mật khẩu...",
      hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );
}

