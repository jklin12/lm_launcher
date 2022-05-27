import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/menu_model.dart';
import 'package:lm_launcher/model/weather_model.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:lm_launcher/pages/utils/weather_status.dart';
import 'package:lm_launcher/service/weather_controller.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  final controller = Get.put(WeatherController());
  final weatherStatus = Get.put(WeatherStatus());

  String? timeString;

  List<MenuModel> menuModel = [
    MenuModel(
        title: 'TV',
        image: "assets/images/Putih-12.png",
        url: "/tv",
        type: 'inApp',
        node: FocusNode()),
    MenuModel(
        title: 'Radio',
        image: "assets/images/Putih-11.png",
        url: "com.google.android.youtube.tvmusic",
        node: FocusNode()),
    MenuModel(
        title: 'Youtube',
        image: "assets/images/Putih-14.png",
        url: "com.google.android.youtube.tv",
        node: FocusNode()),
    MenuModel(
        title: 'Youtube Kids',
        image: "assets/images/Putih-13.png",
        url: "com.google.android.youtube.tvkids",
        node: FocusNode()),
    MenuModel(
        title: 'Netflix',
        image: "assets/images/Putih-10.png",
        url: "com.netflix.ninja",
        node: FocusNode()),
    MenuModel(
        title: 'Spotify',
        image: "assets/images/Putih-09.png",
        url: "com.spotify.tv.android",
        node: FocusNode()),
    MenuModel(
        title: 'Info',
        image: "assets/images/Putih-08.png",
        url: InfoPage.routeName,
        type: 'inApp',
        node: FocusNode()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeString = _formatDateTime(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              "https://thumb.viva.co.id/media/frontend/thumbs3/2018/08/10/5b6d4ea153766-salah-satu-ruang-kamar-hotel-88_1265_711.jpg"),
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
              Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder<WeatherModel>(
                    future: controller.getWeatherData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        var weatherIcon =
                            weatherStatus.getWeatherIcon(data!.cod);

                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Row(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
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
                    text: const TextSpan(
                      text: 'Welcome, ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Roboto Condensed',
                          color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mr Jhon Doe',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto Condensed',
                                color: Colors.white)),
                        TextSpan(
                            text: '\n Room 324',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Roboto Condensed',
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                            return FocusTraversalOrder(
                              order: NumericFocusOrder(0.0 + index),
                              child: TextButton(
                                onPressed: () => false,
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(
                                              MaterialState.focused) ||
                                          states.contains(
                                              MaterialState.pressed)) {
                                        //menuIndex = index;
                                        return const Color(0XFFAB8C56)
                                            .withOpacity(0.8);
                                      }
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    return const Color(0XFFFFFFFF);
                                  }),
                                  elevation: MaterialStateProperty.resolveWith<
                                      double?>((Set<MaterialState> states) {
                                    return 50;
                                  }),
                                  padding: MaterialStateProperty.resolveWith<
                                          EdgeInsetsGeometry?>(
                                      (Set<MaterialState> states) {
                                    return const EdgeInsets.symmetric(
                                        horizontal: 15);
                                  }),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  menuModel[index].image!))),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                          (menuModel[index].title!)
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Roboto Condensed',
                                              color: Color(0XFFAB8C56))),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
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
