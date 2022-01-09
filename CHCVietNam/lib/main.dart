
import 'package:chc/src/widgets/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Hello",
    home: SplashScreen(),
  ));
}