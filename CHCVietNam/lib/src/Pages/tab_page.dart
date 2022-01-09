import 'package:chc/src/Models/users.dart';
import 'package:chc/src/Pages/DocsPage.dart';
import 'package:chc/src/Pages/hictoric_event_page.dart';
import 'package:chc/src/Pages/home_page.dart';
import 'package:chc/src/Pages/search_page.dart';
import 'package:chc/src/Pages/setting_page.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  //final Users user;
  TabPage({ Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  List<Widget> _widgetOptions = [
    HomePage(),
    SearchPage(),
    HistoricEventPage(),
    SettingPage(),
  ];

  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedItemIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: myIndigoblue,
      iconSize: 30.0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      currentIndex: _selectedItemIndex,
      onTap: _cambiarWidget,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",backgroundColor: myIndigoblue),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm",backgroundColor: myIndigoblue),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Ngày",backgroundColor: myIndigoblue),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Tùy chỉnh",backgroundColor: myIndigoblue),
      ],
    );
  }
}