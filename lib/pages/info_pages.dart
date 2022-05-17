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
  int? menundex;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM kk:mm').format(now);
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
              height: 80,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(8, 1, 0, 0.5),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 25,
                          ),
                          Text(
                            formattedDate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Roboto Condensed',
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.blue,
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Welcome Room 132",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto Condensed',
                                  color: Colors.white)),
                          Text("TV ID : " + (args.deviceId).toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto Condensed',
                                  color: Colors.white))
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
                                    AssetImage("assets/images/Putih-08.png"))),
                      ),
                      title: const Text(
                        "Hotel Info",
                        style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed',color: Colors.white)
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
              "assets/images/Putih-06.png", focusNode1, 1),
          _tile('Manager Greeting', tab == 1 ? Colors.blue : Colors.white, 1,
              "assets/images/Putih-01.png", focusNode2, 2),
          _tile('Fasilities', tab == 2 ? Colors.blue : Colors.white, 2,
              "assets/images/Putih-02.png", focusNode3, 3),
          _tile('Meeteng & Event', tab == 3 ? Colors.blue : Colors.white, 3,
              "assets/images/Putih-05.png", focusNode4, 4),
          _tile('Atraction', tab == 4 ? Colors.blue : Colors.white, 4,
              "assets/images/Putih-03.png", focusNode5, 5),
          _tile('Transportation', tab == 5 ? Colors.blue : Colors.white, 5,
              "assets/images/Putih-04.png", focusNode6, 6),
        ],
      ),
    );
  }

  Widget _tile(String label, Color color, int tabx, String img,
      FocusNode focused, int idx) {
    return SizedBox(
      height: 40,
      child: RawKeyboardListener(
        focusNode: focused,
        onKey: ((value) async {
          print(idx);
          if (value.data.logicalKey.debugName == "Select") {}
          setState(() {
            tab = idx - 1;
          });
        }),
        child: TextButton(
          onPressed: () {},
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
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img))),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                label.toUpperCase(),
                style: const TextStyle(fontSize: 15.0, fontFamily: 'Roboto Condensed',color: Colors.white)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
