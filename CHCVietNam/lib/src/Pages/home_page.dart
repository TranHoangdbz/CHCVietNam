import 'package:chc/src/components/category_selector.dart';
import 'package:chc/src/components/post_carousel.dart';
import 'package:chc/src/components/search_bar.dart';
import 'package:chc/src/components/tiled_post_view.dart';
import 'package:chc/src/components/topbar.dart';
import 'package:chc/src/components/welcome_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:10, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBar(),
                      SizedBox(height: 20,),
                      WelcomeWidget(),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                PostCarousel(),
                SizedBox(height: 16,),
                CategorySelector(),
                SizedBox(height: 10,),
                TiledPostView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}