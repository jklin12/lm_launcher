import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/atraction_model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int? tab;

  List<AtractionModel> atractionModel = [
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

  List<AtractionModel> facilitesModel = [
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tab = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xff000000),
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(8, 1, 0, 0.5), BlendMode.dstATop),
            )),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FlutterLogo(
                          size: 50,
                        ),
                        Text(
                          formattedDate,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Welcome Room 132",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        Text(
                          "ID XVLM1326GH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 3,
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/info.png"))),
                      ),
                      title: const Text(
                        "Hotel Info",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    const Divider(
                        color: Colors.black, thickness: 2.0, height: 1),
                    SizedBox(
                      width: 900,
                      height: 260,
                      child: Row(
                        children: [
                          leftDrawer(200),
                          tab == 0 ? aboutUs() : Container(),
                          tab == 1 ? managerGreeting() : Container(),
                          tab == 2 ? facilities(facilitesModel) : Container(),
                          tab == 4 ? atrraction(atractionModel) : Container(),

                          //facilities(facilitesModel)
                          //atrraction(atractionModel)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget managerGreeting() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "GREETING FROM US",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 550,
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
          ),
        ],
      ),
    );
  }

  Widget aboutUs() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "About Us",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 350,
                child: Text(
                    "Aston Batam Hotel & Residence merupakan hotel baru di Batam dan hotel bintang empat yang terletak di pusat Batam, kota dimana bisnis dan hiburan menyatu dalam harmoni. Hotel ini terletak hanya 25 menit dari Bandara Hang Nadim dan hanya 8 menit dari Terminal Feri Harbour Bay, Pusat Perbelanjaan, Lapangan Golf menjadikannya salah satu pusat perdagangan paling strategis di Indonesia."),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200.0,
            height: 300.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  "https://media-cdn.tripadvisor.com/media/photo-s/10/63/9f/78/getlstd-property-photo.jpg"),
              fit: BoxFit.cover,
            )),
          ),
        )
      ],
    );
  }

  Widget facilities(List<AtractionModel> atractionModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 550,
        height: 250,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                childAspectRatio: 0.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10),
            itemCount: atractionModel.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(atractionModel[index].image!),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        atractionModel[index].title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget atrraction(List<AtractionModel> atractionModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 500,
        height: 250,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: atractionModel.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
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
                          fontSize: 13.0,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget leftDrawer(double size) {
    return Container(
      width: size,
      color: Colors.white,
      child: Column(
        children: [
          _tile('About Us', tab == 0 ? Colors.blue : Colors.white, 0),
          _tile('Manager Greeting', tab == 1 ? Colors.blue : Colors.white, 1),
          _tile('Fasilities', tab == 2 ? Colors.blue : Colors.white, 2),
          _tile('Meeteng & Event', tab == 3 ? Colors.blue : Colors.white, 3),
          _tile('Atraction', tab == 4 ? Colors.blue : Colors.white, 4),
          _tile('Trsnportasion', tab == 5 ? Colors.blue : Colors.white, 5),
        ],
      ),
    );
  }

  Widget _tile(String label, Color color, int tabx) {
    return Container(
      height: 40,
      color: color,
      width: 200,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                tab = tabx;
              });
            },
            child: Text(
              label,
            ),
          ),
        ),
      ),
    );
  }
}
