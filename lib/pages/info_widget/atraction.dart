import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';
import 'package:lm_launcher/model/facilites_model.dart';
import 'package:lm_launcher/pages/info_widget/detail_facilities.dart';
import 'package:lm_launcher/pages/widget/atraction_card.dart';

class Atraction extends StatelessWidget {
  final List<FacilitesModel>? atractionModel2;
  final List<AtractionModel> atractionModel = [
    AtractionModel(
        title: 'JEMBATAN BARELANG',
        image:
            "https://tempatwisata.b-cdn.net/wp-content/uploads/2021/08/Jembatan-Barelang-By-@rahmat5158.jpg"),
    AtractionModel(
        title: 'NAGOYA HILL',
        image:
            "https://media.suara.com/pictures/970x544/2021/06/08/99063-ilustrasi-nagoya-hill-batam.jpg"),
    AtractionModel(
        title: 'OCARINA BATAM',
        image:
            "https://www.pantainesia.com/wp-content/uploads/2020/04/Pantai-Ocarina-Batam.jpg"),
    AtractionModel(
        title: 'SOUTHLINK COUNTRY CLUB',
        image:
            "https://i0.wp.com/batamekbiz.com/wp-content/uploads/2020/11/Southlinks-Country-Club-Batam.png?fit=700%2C390&ssl=1"),
  ];

  Atraction({Key? key, this.atractionModel2}) : super(key: key);
  int selected = 0;
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    List<FocusNode> focusNodes = List<FocusNode>.generate(
        atractionModel2!.length, (int index) => FocusNode());

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
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: atractionModel2!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return AtractionCard(
                      focusNode: focusNodes[index],
                      image: 'http://202.169.224.46/lm_launcher' +
                          atractionModel2![index].nama!,
                      title: atractionModel2![index].title!,
                      listImage: atractionModel2![index].datas,
                    );
                  }),
            ),
    );
  }
}
