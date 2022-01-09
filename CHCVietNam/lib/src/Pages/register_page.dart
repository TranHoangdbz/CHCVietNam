
import 'package:chc/src/authentication/auth_bloc.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/widgets/loading.dart';
import 'package:chc/src/widgets/msg_dialog.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  late TextEditingController _nameControler;
  late TextEditingController _emailcontroler ;
  late TextEditingController _passwordcontroler ;
  AuthBloc authBloc = new AuthBloc();
  final _formkey = GlobalKey<FormState>();


  @override
  void initState(){
    _nameControler = TextEditingController();
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
                    "Đăng ký",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Vui lòng nhập thông tin tài khoản",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 40,),
                  _title(Icons.person, "Tên hiển thị"),
                  _nameTextField(),
                  SizedBox(height: 20,),
                  _title(Icons.email, "Email"),
                  _emailTextField(),
                  SizedBox(height: 20,),
                  _title(Icons.lock, "Mật khẩu"),
                  _passwordTextField(),
                  SizedBox(height: 30,),
                  MaterialButton(
                    onPressed: (){
                      if(_formkey.currentState!.validate())
                      {
                        SignUp();
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
                      "Đăng ký",
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
                      Text("Bạn đã có tài khoản?"),
                      SizedBox(width: 5,),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text(
                        "Đăng nhập ngay",
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignUp(){
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    authBloc.signUp(_emailcontroler.text, _passwordcontroler.text,
        "000000", _nameControler.text, () {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage(uid: "19520568")));
        }, (msg) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Sign-In", msg);
          // show msg dialog
        });
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage(uid: "")));
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

  _nameTextField() => TextFormField(
    style: TextStyle(
        fontSize: 14,
        color: Colors.grey
    ),
    controller: _nameControler,
    //cursorColor: myGreen,
    decoration: InputDecoration(
      hintText: "Nhập tên",
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
        return "Vui lòng nhập tên";
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
