import 'package:carousel_slider/carousel_slider.dart';
import 'package:chc/src/components/Values.dart';
import 'package:flutter/material.dart';

class PostCarousel extends StatelessWidget{
  PostCarousel({Key? key}) : super(key : key);
  final StaticValues staticValues = StaticValues();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(height: 250.0),
      items: staticValues.posts.map((postItem) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                      postItem.image,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: 250,),
                    ),
                    Container(
                      width: size.width,
                      height: 250,
                      //margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x77777777),
                              Color(0x00000000),
                              Color(0x00000000),
                              Color(0xCC000000),
                            ]
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          postItem.title,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
            );
          },
        );
      }).toList(),
    );
  }
}