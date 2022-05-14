import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/atraction_model.dart';
import 'package:lm_launcher/pages/info_widget/about.dart';
import 'package:lm_launcher/pages/info_widget/atraction.dart';
import 'package:lm_launcher/pages/info_widget/facilities.dart';
import 'package:lm_launcher/pages/info_widget/manager_greeting.dart';
import 'package:lm_launcher/utils/InfoArguments.dart';

class InfoPage extends StatefulWidget {
  static const routeName = '/info';

  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int? tab;

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
    final args = ModalRoute.of(context)!.settings.arguments as InfoArguments;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Container(
              height: 110,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(8, 1, 0, 0.5),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/logo.png"),
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
                        children: [
                          const Text(
                            "Welcome Room 132",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                          Text(
                            "ID " + (args.deviceId).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 8.0),
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 3.12,
                color: const Color.fromRGBO(8, 1, 0, 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Putih-06.png"))),
                      ),
                      title: const Text(
                        "Hotel Info",
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                    const Divider(
                        color: Colors.white, thickness: 2.0, height: 1),
                    SizedBox(
                      width: 900,
                      height: 250,
                      child: Row(
                        children: [
                          leftDrawer(200),
                          tab == 0 ? const AboutUs() : Container(),
                          tab == 1 ? const ManagerGreeting() : Container(),
                          tab == 2 ? Facilities() : Container(),
                          tab == 4 ? Atraction() : Container(),

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

  Widget leftDrawer(double size) {
    return Container(
      width: size,
      color: const Color(0XFF0C0D11),
      child: ListView(
        children: [
          _tile('About Us', tab == 0 ? Colors.blue : Colors.white, 0,
              "assets/images/Putih-01.png"),
          _tile('Manager Greeting', tab == 1 ? Colors.blue : Colors.white, 1,
              "assets/images/Putih-02.png"),
          _tile('Fasilities', tab == 2 ? Colors.blue : Colors.white, 2,
              "assets/images/Putih-03.png"),
          _tile('Meeteng & Event', tab == 3 ? Colors.blue : Colors.white, 3,
              "assets/images/Putih-04.png"),
          _tile('Atraction', tab == 4 ? Colors.blue : Colors.white, 4,
              "assets/images/Putih-05.png"),
          _tile('Trsnportasion', tab == 5 ? Colors.blue : Colors.white, 5,
              "assets/images/Putih-06.png"),
        ],
      ),
    );
  }

  Widget _tile(String label, Color color, int tabx, String img) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: () {
          setState(() {
            setState(() {
              tab = tabx;
            });
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (tabx == tab) {
                return const Color(0XFF007BF9).withOpacity(0.8);
              }
              return null; // Defer to the widget's default.
            },
          ),
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
          minimumSize: MaterialStateProperty.resolveWith<Size?>(
              (Set<MaterialState> states) {
            return Size.zero;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration:
                  BoxDecoration(image: DecorationImage(image: AssetImage(img))),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
