import 'package:chc/src/components/post_carousel.dart';
import 'package:chc/src/components/tiled_post_view.dart';
import 'package:flutter/material.dart';

class CulturePage extends StatefulWidget{
  final String category;
  const CulturePage({required this.category, Key? key}) : super(key: key);

  @override
  _CulturePageState createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(top:10, left: 16, right: 16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // TopBar(),
                  //       SizedBox(height: 20,),
                  //       WelcomeWidget(),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 10,),
                  PostCarousel(),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: TabBar(
                  //     isScrollable: true,
                  //     unselectedLabelColor: Colors.grey,
                  //     labelColor: Colors.white,
                  //     indicatorSize: TabBarIndicatorSize.tab,
                  //     indicatorColor: Colors.white,
                  //     indicator: BubbleTabIndicator(
                  //       indicatorHeight: 25,
                  //       indicatorColor: myIndigoblue,
                  //       tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  //     ),
                  //     tabs: [
                  //       Tab(text: 'Văn hóa',),
                  //       Tab(text: 'Lịch sử',),
                  //       Tab(text: 'Ẩm thực',),
                  //       Tab(text: 'Âm nhạc',),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 16,),
                  //CategorySelector(),
                  SizedBox(height: 10,),
                  TiledPostView(category: widget.category),
                ],
              ),
            ),
          ),
        );
  }

}