import 'dart:async';
import 'package:chc/src/firebase/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();

  Stream? get emailStream => _emailController.stream;
  Stream? get passStream => _passController.stream;

  bool checkSignIn(String email, String pass) {
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("");

    return true;
  }
  // bool updatePassWord(String pass){
  //   return this._firAuth.updatePass(pass);
  // }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, phone, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  bool updatePass(String pass){
    return this._firAuth.updatePass(pass);
    return true;
  }

  void dispose() {
    _emailController.close();
    _passController.close();
  }
}