import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';
import 'package:lm_launcher/model/facilites_model.dart';
import 'package:lm_launcher/pages/info_widget/detail_facilities.dart';

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

  Facilities({Key? key, List<FacilitesModel>? facilities}) : super(key: key);

  int selected = 0;
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
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
                  itemCount: facilitesModel.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed)) {
                              print(isSelect);
                              isSelect = true;
                              selected = facilitesModel[index].selected ?? 0;
                              return const Color(0XFF007BF9).withOpacity(0.8);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                        elevation: MaterialStateProperty.resolveWith<double?>(
                            (Set<MaterialState> states) {
                          //if (states.contains(MaterialState.pressed) || states.contains(MaterialState.focused)) return 5;
                          return 5;
                        }),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Color(0XFF0C0D11);
                        }),
                        minimumSize: MaterialStateProperty.resolveWith<Size?>(
                            (Set<MaterialState> states) {
                          return Size.zero;
                        }),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(facilitesModel[index].image!),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(facilitesModel[index].title!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto Condensed',
                                      color: Colors.white)))
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
