import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/channe_model.dart';
import 'package:lm_launcher/pages/utils/color_loader.dart';
import 'package:lm_launcher/pages/utils/weather_status.dart';
import 'package:lm_launcher/pages/widget/radio_card.dart';
import 'package:lm_launcher/utils/info_argument.dart';

class TvChannelPages extends StatefulWidget {
  const TvChannelPages({Key? key}) : super(key: key);

  @override
  State<TvChannelPages> createState() => _TvChannelPagesState();
}

class _TvChannelPagesState extends State<TvChannelPages> {
  final weatherStatus = Get.put(WeatherStatus());

  bool isLoading = true;
  String? name;
  String? image;
  String? tvRoom;
  String? tvId;
  String? timeString;

  List<FocusNode> focusNodes = [];
  List<ChanneModel> channelModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //timeString = _formatDateTime(DateTime.now());
    //Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
    readJson();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        getHomeData(tvId ?? '');
      });
    });
  }

  Future<void> readJson() async {
    var response = await Dio().get(
      'https://iptv-org.github.io/iptv/channels.json',
    );
    final data = (response.data);
    List newList = [];
    for (var i = 0; i < data.length; i++) {
      if (i > 110 && i < 120) {
        newList.add(data[i]);
      }
    }

    setState(() {
      channelModel = (newList).map((e) {
        return ChanneModel.fromJson(e);
      }).toList();
      focusNodes = List<FocusNode>.generate(
          channelModel.length, (int index) => FocusNode());
      focusNodes[0].requestFocus();
    });
  }

  getHomeData(String tvId) async {
    print(tvId);
    var response = await Dio().get(
      'http://202.169.224.46/lm_launcher/index.php/api/info?tv_id=$tvId',
    );
    var datas = (response.data);

    if (datas['status'] == true) {
      setState(() {
        name = datas['data']['tv_name'] ?? '';
        tvRoom = datas['data']['tv_room'] ?? '';
        image = datas['data']['tv_background'];
        isLoading = false;
      });
    }
  }

  /* void getTime() {
    final DateTime now = DateTime.now();
    //print(now);
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      timeString = formattedDateTime;
    });
  }*/

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss \n EEE d MMM').format(dateTime);
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as InfoArguments;
    tvId = args.deviceId;

    return Scaffold(
        body: isLoading
            ? Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(177, 0, 0, 0),
                      Color.fromARGB(124, 31, 5, 5),
                      Color(0x00000000),
                      Color.fromARGB(164, 0, 0, 0),
                    ],
                  ),
                ),
                child: const Center(
                    child: ColorLoader5(
                  dotOneColor: Colors.pink,
                  dotTwoColor: Colors.amber,
                  dotThreeColor: Colors.deepOrange,
                  duration: Duration(seconds: 2),
                )),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://202.169.224.46/lm_launcher/$image"),
                    fit: BoxFit.cover,
                  ),
                ),
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
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  weatherStatus
                                      .getWeatherIcon(args.weatherIcon),
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      args.weatherTemp,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto Condensed',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      args.weatherStatus,
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
                                /*Text(
                                  timeString!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Roboto Condensed',
                                      color: Colors.white),
                                )*/
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/logos.png",
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
                                text: greetingMessage() + ', ',
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisExtent: 200,
                                      mainAxisSpacing: 20),
                              itemCount: channelModel.length,
                              itemBuilder: (context, index) {
                                return RadioCard(
                                  focusNode: focusNodes[index],
                                  title: channelModel[index].name,
                                  image: channelModel[index].logo,
                                  url: channelModel[index].url,
                                  type: 'tv',
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
