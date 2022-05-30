import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/home_model.dart';
import 'package:lm_launcher/model/menu_model.dart';
import 'package:lm_launcher/model/menu_model2.dart';
import 'package:lm_launcher/model/weather_model.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:lm_launcher/pages/utils/weather_status.dart';
import 'package:lm_launcher/pages/widget/custom_button.dart';
import 'package:lm_launcher/service/home_controller.dart';
import 'package:lm_launcher/service/weather_controller.dart';
import 'package:platform_device_id/platform_device_id.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  final controller = Get.put(WeatherController());
  final weatherStatus = Get.put(WeatherStatus());
  final homeController = Get.put(HomeController());

  String? timeString;
  String? name;
  String? message;
  String? image;
  String? tvRoom;
  String? tvId;
  bool isLoading = true;
  List<FocusNode> focusNodes = [];
  HomeModel? homeModel;
  List<MenuModel2> menuModel = [];
  /*List<MenuModel> menuModel = [
    MenuModel(
        title: 'TV',
        image: "assets/svg/1653460465icon-contact.svg",
        url: "/tv",
        type: 'inApp',
        node: FocusNode()),
    MenuModel(
        title: 'Radio',
        image: "assets/svg/Putih-11.svg",
        url: "com.google.android.youtube.tvmusic",
        node: FocusNode()),
    MenuModel(
        title: 'Youtube',
        image: "assets/svg/Putih-14.svg",
        url: "com.google.android.youtube.tv",
        node: FocusNode()),
    MenuModel(
        title: 'Youtube Kids',
        image: "assets/svg/Putih-13.svg",
        url: "com.google.android.youtube.tvkids",
        node: FocusNode()),
    MenuModel(
        title: 'Netflix',
        image: "assets/svg/Putih-12.svg",
        url: "com.netflix.ninja",
        node: FocusNode()),
    MenuModel(
        title: 'Spotify',
        image: "assets/svg/Putih-08.svg",
        url: "com.spotify.tv.android",
        node: FocusNode()),
    MenuModel(
        title: 'Info',
        image: "assets/svg/Putih-08.svg",
        url: InfoPage.routeName,
        type: 'inApp',
        node: FocusNode()),
  ];*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    //openAlertBox();
    setWallpaper();
    timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("message ");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        openAlertBox(message.notification!.title ?? '', message.data['type'],
            message.data['datas']);
        //print('Message also contained a notification: ${message.notification.title}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("object");
      print('A new onMessageOpenedApp event was published! $message');
    });
  }

  getTOken() async {
    String? token;
    token = await FirebaseMessaging.instance.getToken();
    //print(token);
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

  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      tvId = deviceId;
    });
    getHomeData(deviceId ?? '');
    print("deviceId->$deviceId");
  }

  getHomeData(String tvId) async {
    var response = await Dio().post(
      'http://202.169.224.46/lm_launcher/index.php/api/home?tv_id=$tvId',
    );
    var datas = json.decode(response.data);
    print(datas);
    if (datas['status'] == true) {
      setState(() {
        name = datas['data']['tv_name'];
        tvRoom = datas['data']['tv_room'];
        image = datas['data']['tv_background'];
        message = datas['data']['tv_text_info'];
        menuModel = (datas['data_menu'] as List).map((e) {
          return MenuModel2.fromJson(e);
        }).toList();
        focusNodes = List<FocusNode>.generate(
            menuModel.length, (int index) => FocusNode());

        focusNodes[0].requestFocus();

        isLoading = false;
        print(menuModel.length);
      });
    }
  }

  Future<void> setWallpaper() async {
    try {
      String url = "https://images.unsplash.com/photo-1542435503-956c469947f6";
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print("set walapaper $result");
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    // _focusNodes[0].requestFocus();
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage("http://202.169.224.46/lm_launcher/$image"),
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
                child: Stack(
                  children: [
                    /*Padding(
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
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 8.0, right: 8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 50,
                          child: FocusTraversalGroup(
                            policy: OrderedTraversalPolicy(),
                            child: ListView.separated(
                              itemCount: menuModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CustomButton(
                                  focusNode: focusNodes[index],
                                  title: menuModel[index].menuTitle,
                                  image: 'http://202.169.224.46/lm_launcher' +
                                      menuModel[index].menuImage!,
                                  image2: 'http://202.169.224.46/lm_launcher' +
                                      menuModel[index].menuImage2!,
                                  urlType: menuModel[index].menuType,
                                  url: menuModel[index].menuUrl,
                                  devideId: tvId,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(message ?? '',
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Roboto Condensed',
                                color: Color(0XFFFFFFFF))),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  openAlertBox(String title, String type, String datas) async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              width: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: const BoxDecoration(
                      color: Color(0XFFAB8C56),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto Condensed',
                          color: Color(0XFFFFFFFF)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: type == 'image'
                        ? Image.network(datas)
                        : Text(
                            datas,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Roboto Condensed',
                                color: Color(0XFFAB8C56)),
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class OrderedButtonRow extends StatelessWidget {
  const OrderedButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Row(
        children: <Widget>[
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(2.0),
            child: TextButton(
              onFocusChange: (value) {
                print(value);
              },
              child: const Text('ONE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(1.0),
            child: TextButton(
              child: const Text('TWO'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(3.0),
            child: TextButton(
              child: const Text('THREE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
