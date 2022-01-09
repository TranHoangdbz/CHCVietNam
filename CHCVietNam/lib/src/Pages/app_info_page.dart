import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:flutter/material.dart';

class AppInfoPage extends StatefulWidget{
  final String uid;
  const AppInfoPage({required this.uid, Key? key}) : super(key: key);

  @override
  _AppInfoPageState createState() => _AppInfoPageState();

}

class _AppInfoPageState extends State<AppInfoPage> {

  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Thông tin"),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 160,),
              ],
            ),
          )
      ),
    );
  }
}