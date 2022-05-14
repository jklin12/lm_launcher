import 'package:flutter/material.dart';
import 'package:lm_launcher/model/atraction_model.dart';

class Atraction extends StatelessWidget {
  final List<AtractionModel> atractionModel = [
    AtractionModel(
        title: 'Tugu Yogyakarta',
        image:
            "https://asset.kompas.com/crops/43BL_Jv4whTBdcNNbDwb7HFF_Fo=/0x0:1000x667/750x500/data/photo/2020/03/10/5e677a1b83e8d.jpg"),
    AtractionModel(
        title: 'Malioboro',
        image:
            "https://jogjarafira.com/wp-content/uploads/2019/03/Suasana-Malam-Jalan-Malioboro-Jogja-sumber-ig-wonderfuljogja.jpg"),
    AtractionModel(
        title: '0KM Yogyakarta',
        image:
            "https://nalarpolitik.com/wp-content/uploads/2018/06/Nuansa-Eropa-di-Nol-Kilometer-Yogyakarta.jpg"),
    AtractionModel(
        title: 'Pantai Parangtritis',
        image:
            "https://1.bp.blogspot.com/-ib311gV-P0s/XR5OHBnL_kI/AAAAAAAABJ0/p1ivrgbsIlIZJmeOJmgFhQg4FQTjQyzMQCLcBGAs/s640/Keindahan-Pantai-Parangtritis-Yogyakarta.jpg"),
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
                maxCrossAxisExtent: 120,
                childAspectRatio: 1.01,
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
