import 'package:chc/src/firebase/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  ProfileFB profileFB = new ProfileFB();

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.user!.uid, email, name, onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Sign-In fail, please try again");
    });
  }

  _createUser(String uid, String email, String name, Function onSuccess,
      Function(String) onRegisterError) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("account");
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    FirebaseFirestore.instance.collection("account").doc(uid).set({
      "idUser" : id,
      "uid" : uid,
      "email" : email
    }
    ).then((value) { print("completed");
    onSuccess();
    profileFB.add(uid, name, "");
    })
        .catchError((error){print("fail");onRegisterError("SignUp fail, please try again");}).whenComplete(() => print("completeddd"));
  }

  ///
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  bool   updatePass(String pass){
    bool result=true;
    this._fireBaseAuth.currentUser!.updatePassword(pass).then((_){
      print("Successfully changed password");
      result= true;
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      result= false;
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    return result;
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}