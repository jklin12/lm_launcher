import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/atraction_model.dart';
import 'package:lm_launcher/model/menu_model.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:platform_device_id/platform_device_id.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _deviceId;

  List<MenuModel> menuModel = [
    MenuModel(title: 'Live TV', image: "assets/images/tv.png", url: ""),
    MenuModel(title: 'Radio', image: "assets/images/radio.png", url: ""),
    MenuModel(
        title: 'Youtube',
        image: "assets/images/youtube.png",
        url: "com.google.android.youtube.tv"),
    MenuModel(
        title: 'Youtube Kids', image: "assets/images/yt_kids.png", url: ""),
    MenuModel(
        title: 'Netflix',
        image: "assets/images/netflix.png",
        url: "com.netflix.mediaclient"),
    MenuModel(
        title: 'Spotify',
        image: "assets/images/spotify.png",
        url: "com.spotify.music"),
    MenuModel(
        title: 'Info',
        image: "assets/images/info.png",
        url: "/info",
        type: 'inApp'),
  ];

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
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
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
                        Container(
                          width: 150,
                          height: 70,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.cover)),
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
                          "ID " + (_deviceId!).toUpperCase(),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: menuModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 120,
                        child: InkWell(
                          onTap: () async {
                            if (menuModel[index].type != null &&
                                menuModel[index].type == 'inApp') {
                              Navigator.pushNamed(
                                  context, menuModel[index].url!);
                            } else {
                              await LaunchApp.openApp(
                                  androidPackageName: menuModel[index].url,
                                  openStore: false);
                            }
                          },
                          child: Card(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  menuModel[index].image!))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      child: Text(
                                        menuModel[index].title!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
