import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailFacilities extends StatelessWidget {
  const DetailFacilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5]  ;
    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: CarouselSlider(
        options: CarouselOptions(),
        items: list
            .map((item) => Container(
                  child: Center(child: Text(item.toString())),
                  color: Colors.green,
                ))
            .toList(),
      ),
    );
  }
}
