import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';

class Atraction extends StatelessWidget {
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

  Atraction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 500,
        height: 250,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 125,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: atractionModel.length,
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
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(atractionModel[index].image!),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Text(
                        atractionModel[index].title!,
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
