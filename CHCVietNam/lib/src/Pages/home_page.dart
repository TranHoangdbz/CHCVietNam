import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:chc/src/Pages/tiled_list/culture_page.dart';
import 'package:chc/src/colors/colors.dart';
import 'package:chc/src/components/category_selector.dart';
import 'package:chc/src/components/post_carousel.dart';
import 'package:chc/src/components/search_bar.dart';
import 'package:chc/src/components/tiled_post_view.dart';
import 'package:chc/src/components/topbar.dart';
import 'package:chc/src/components/welcome_widget.dart';
import 'package:chc/src/widgets/appbars/customAppbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key : key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final List<Tab> tabs =  <Tab>[
    new Tab(text: "Văn hóa",),
    new Tab(text: "Lịch sử",),
    new Tab(text: "Ẩm thực",),
    new Tab(text: "Âm nhạc",),
  ];

  late TabController _tabController;

  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Column(
                children: [
                  ListTile(
                    title: Text("MY VIETNAM",
                      style: TextStyle(fontSize: 24,fontFamily: 'Arima',fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.end,),
                    subtitle: Text("Cùng khám phá văn hóa, lịch sử Việt Nam",
                        style: TextStyle(
                          fontSize: 16,
                        ),textAlign: TextAlign.end),

                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.white,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 25,
                        indicatorColor: myIndigoblue,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      tabs: [
                        Tab(text: 'Văn hóa',),
                        Tab(text: 'Lịch sử',),
                        Tab(text: 'Ẩm thực',),
                        Tab(text: 'Âm nhạc',),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              CulturePage(category: "Văn hóa"),
              CulturePage(category: "Lịch sử"),
              CulturePage(category: "Ẩm thực"),
              CulturePage(category: "Âm nhạc"),
            ],
          ),
          // body: SafeArea(
          //   child: Container(
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.vertical,
          //       child: Column(
          //         children: [
          //           // Container(
          //           //   margin: EdgeInsets.only(top:10, left: 16, right: 16),
          //           //   child: Column(
          //           //     crossAxisAlignment: CrossAxisAlignment.start,
          //           //     children: [
          //           //       // TopBar(),
          //           //       SizedBox(height: 20,),
          //           //       WelcomeWidget(),
          //           //     ],
          //           //   ),
          //           // ),
          //           SizedBox(height: 10,),
          //           PostCarousel(),
          //           // Align(
          //           //   alignment: Alignment.topLeft,
          //           //   child: TabBar(
          //           //     isScrollable: true,
          //           //     unselectedLabelColor: Colors.grey,
          //           //     labelColor: Colors.white,
          //           //     indicatorSize: TabBarIndicatorSize.tab,
          //           //     indicatorColor: Colors.white,
          //           //     indicator: BubbleTabIndicator(
          //           //       indicatorHeight: 25,
          //           //       indicatorColor: myIndigoblue,
          //           //       tabBarIndicatorSize: TabBarIndicatorSize.tab,
          //           //     ),
          //           //     tabs: [
          //           //       Tab(text: 'Văn hóa',),
          //           //       Tab(text: 'Lịch sử',),
          //           //       Tab(text: 'Ẩm thực',),
          //           //       Tab(text: 'Âm nhạc',),
          //           //     ],
          //           //   ),
          //           // ),
          //           SizedBox(height: 16,),
          //           //CategorySelector(),
          //           SizedBox(height: 10,),
          //           TiledPostView(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}