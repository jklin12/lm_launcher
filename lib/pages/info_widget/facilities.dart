import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';
import 'package:lm_launcher/model/facilites_model.dart';
import 'package:lm_launcher/pages/info_widget/detail_facilities.dart';
import 'package:lm_launcher/pages/widget/facilities_card.dart';

class Facilities extends StatelessWidget {
  final List<AtractionModel> facilitesModel = [
    AtractionModel(
        title: 'Swiming Pool',
        image: "assets/images/hitam-01.png",
        selected: 0),
    AtractionModel(
        title: 'GYM', image: "assets/images/hitam-02.png", selected: 1),
    AtractionModel(
        title: 'Papemint Lounge',
        image: "assets/images/hitam-03.png",
        selected: 2),
    AtractionModel(
        title: 'Basil Restaurant',
        image: "assets/images/hitam-04.png",
        selected: 3),
    AtractionModel(
        title: 'Whril Poll & Sauna',
        image: "assets/images/hitam-05.png",
        selected: 4),
    AtractionModel(
        title: 'Gravity 10 Bar & Grill',
        image: "assets/images/hitam-06.png",
        selected: 5),
  ];

  Facilities({Key? key, this.facilities}) : super(key: key);

  int selected = 0;
  bool isSelect = false;

  final List<FacilitesModel>? facilities;

  @override
  Widget build(BuildContext context) {
    List<FocusNode> focusNodes = List<FocusNode>.generate(
        facilities!.length, (int index) => FocusNode());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isSelect
          ? const DetailFacilities()
          : SizedBox(
              width: 550,
              height: 250,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      childAspectRatio: 1.01,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: facilities!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return FacilitiesCard(
                      focusNode: focusNodes[index],
                      image: 'http://202.169.224.46/lm_launcher' +
                          facilities![index].nama!,
                      title: facilities![index].title!,
                      listImage: facilities![index].datas,
                    );
                  }),
            ),
    );
  }
}
