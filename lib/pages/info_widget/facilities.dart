import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';

class Facilities extends StatelessWidget {
  final List<AtractionModel> facilitesModel = [
    AtractionModel(title: 'Swiming Pool', image: "assets/images/hitam-01.png"),
    AtractionModel(title: 'GYM', image: "assets/images/hitam-02.png"),
    AtractionModel(
        title: 'Papemint Lounge', image: "assets/images/hitam-03.png"),
    AtractionModel(
        title: 'Basil Restaurant', image: "assets/images/hitam-04.png"),
    AtractionModel(
        title: 'Whril Poll & Sauna', image: "assets/images/hitam-05.png"),
    AtractionModel(
        title: 'Gravity 10 Bar & Grill', image: "assets/images/hitam-06.png"),
  ];

  Facilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
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
              return TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return const Color(0XFF007BF9).withOpacity(0.8);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 0;
                    return null;
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
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
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        facilitesModel[index].title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
