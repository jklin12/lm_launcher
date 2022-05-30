import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/facilites_model.dart';
import 'package:lm_launcher/model/info_model.dart';
import 'package:lm_launcher/model/weather_model.dart';
import 'package:lm_launcher/pages/info_widget/about.dart';
import 'package:lm_launcher/pages/info_widget/atraction.dart';
import 'package:lm_launcher/pages/info_widget/facilities.dart';
import 'package:lm_launcher/pages/info_widget/manager_greeting.dart';
import 'package:lm_launcher/pages/utils/weather_status.dart';
import 'package:lm_launcher/pages/widget/info_button.dart';
import 'package:lm_launcher/service/weather_controller.dart';
import 'package:lm_launcher/utils/InfoArguments.dart';

class InfoPageNew extends StatefulWidget {
  static const routeName = '/info';

  const InfoPageNew({Key? key}) : super(key: key);

  @override
  State<InfoPageNew> createState() => _InfoPageNewState();
}

class _InfoPageNewState extends State<InfoPageNew> {
  //final controller = Get.put(WeatherController());
  //final weatherStatus = Get.put(WeatherStatus());
  bool isLoading = true;
  int? tab = 0;
  String? name;
  String? image;
  String? tvRoom;
  String? tvId;
  String? timeString;

  List<FocusNode> focusNodes = [];
  List<InfoModel> infomodel = [];
  List<int> listMneu = [];
  List<FacilitesModel> facilities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        getHomeData(tvId ?? '');
      });
    });
  }

  getHomeData(String tvId) async {
    print(tvId);
    var response = await Dio().post(
      'http://202.169.224.46/lm_launcher/index.php/api/info?tv_id=$tvId',
    );
    var datas = json.decode(response.data);

    if (datas['status'] == true) {
      setState(() {
        name = datas['data']['tv_name'] ?? '';
        tvRoom = datas['data']['tv_room'] ?? '';
        image = datas['data']['tv_background'];
        infomodel = (datas['menu_info'] as List).map((e) {
          return InfoModel.fromJson(e);
        }).toList();
        facilities = (datas['facilities'] as List).map((e) {
          return FacilitesModel.fromJson(e);
        }).toList();
        focusNodes = List<FocusNode>.generate(
            infomodel.length, (int index) => FocusNode());

        focusNodes[0].requestFocus();

        listMneu = List<int>.generate(infomodel.length, (index) => index);

        isLoading = false;
      });
    }
  }

  void getTime() {
    final DateTime now = DateTime.now();
    //print(now);
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss \n EEE d MMM').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as InfoArguments;
    tvId = args.deviceId;
    //getHomeData(args.deviceId);
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:
                      NetworkImage("http://202.169.224.46/lm_launcher/$image"),
                  fit: BoxFit.cover,
                )),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(164, 0, 0, 0),
                        Color.fromARGB(0, 216, 16, 16),
                        Color(0x00000000),
                        Color.fromARGB(164, 0, 0, 0),
                      ],
                    ),
                  ),
                  child: Stack(children: [
                    /* Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FutureBuilder<WeatherModel>(
                            future: controller.getWeatherData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data;
                                var weatherIcon =
                                    weatherStatus.getWeatherIcon(data!.cod);

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      weatherStatus.getWeatherIcon(data.cod),
                                      style: const TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.main!.temp.toString()}°",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Roboto Condensed',
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${data.weather![0].description}",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Roboto Condensed',
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 50.0,
                                    ),
                                    Text(
                                      timeString!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto Condensed',
                                          color: Colors.white),
                                    )
                                  ],
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/logo2.png",
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              text: 'Welcome, ',
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto Condensed',
                                  color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(
                                    text: name ?? '',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto Condensed',
                                        color: Colors.white)),
                                TextSpan(
                                    text: '\n Room  $tvRoom',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Roboto Condensed',
                                        color: Colors.white)),
                              ],
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 2.5,
                        color: const Color.fromRGBO(234, 255, 255, 0.8),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Putih-08.png"))),
                              ),
                              title: const Text("Hotel Info",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto Condensed',
                                      color: Color(0XFFAB8C56))),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    width: 210,
                                    height: 300,
                                    child: ListView.builder(
                                        itemCount: infomodel.length,
                                        itemBuilder: (context, index) {
                                          //print(index);
                                          return InfoButton(
                                            index: index,
                                            focusNode: focusNodes[index],
                                            title: infomodel[index].title,
                                            image:
                                                'http://202.169.224.46/lm_launcher' +
                                                    infomodel[index].image!,
                                            callBack: (value) {
                                              setState(() {
                                                tab = value;
                                              });
                                            },
                                          );
                                        }),
                                  ),
                                ),
                                tab == 0 ? const AboutUs() : Container(),
                                tab == 1
                                    ? const ManagerGreeting()
                                    : Container(),
                                tab == 2 ? Facilities() : Container(),
                                tab == 4 ? Atraction() : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ));
  }
}
