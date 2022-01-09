import 'package:chc/src/authentication/auth_bloc.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:chc/src/widgets/loading.dart';
import 'package:chc/src/widgets/msg_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassWordPage extends StatefulWidget{
  //final String uid;
  const ChangePassWordPage({Key? key}) : super(key: key);

  @override
  ChangePassWordPageState createState() => ChangePassWordPageState();
}

class ChangePassWordPageState extends State<ChangePassWordPage>{

  final _formkey = GlobalKey<FormState>();
  AuthBloc authBloc = new AuthBloc();

  late String ?email;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getemail();
    return Scaffold(
      appBar: customAppBar("Đổi mật khẩu"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 160,),
                  _passwordTextField(),
                  SizedBox(height: 20,),
                  _newPassTextField(),
                  SizedBox(height: 20,),
                  _confirmTextField(),
                  SizedBox(height: 30,),
                  MaterialButton(
                    onPressed: (){
                      if(_formkey.currentState!.validate())
                      {
                        _changePass();
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
                      "Thay đổi mật khẩu",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _passwordTextField() => Container(
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
      controller: _passController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nhập mật khẩu hiện tại"
      ),
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập mật khẩu cũ";
        }
        return null;
      },
    ),
  );

  _newPassTextField() => Container(
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
      controller: _newpassController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nhập mật khẩu mới"
      ),
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập mật khẩu mới";
        }
        return null;
      },
    ),
  );

  _confirmTextField() => Container(
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
      controller: _confirmController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Xác nhận mật khẩu mới"
      ),
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng xác nhận mật khẩu mới";
        }
        if(_confirmController.text != _newpassController.text){
          return "Mật khẩu mới và mật khẩu xác nhận không trùng khớp";
        }
        return null;
      },
    ),
  );

  Future<void> _changePass() async {
    LoadingDialog.showLoadingDialog(context, "Đang thay đổi mật khẩu");
    authBloc.signIn(
        email.toString(),
        this._passController.text,
            () {
          if (this.authBloc.updatePass(this._confirmController.text)) {
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(
                context, "Đã thay đổi mật khẩu", '');
            //Navigator.pop(context);
          }
        },
            (msg) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Sai mật khẩu", '');
          return;
        });
  }
  Future<void> getemail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('email');
    print(status);
    email = status;
  }
}