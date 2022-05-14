import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/menu_model.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:lm_launcher/utils/InfoArguments.dart';
import 'package:platform_device_id/platform_device_id.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _deviceId;
  bool? isHover = false;

  List<MenuModel> menuModel = [
    MenuModel(title: 'Live TV', image: "assets/images/Putih-14.png", url: ""),
    MenuModel(title: 'Radio', image: "assets/images/Putih-13.png", url: ""),
    MenuModel(
        title: 'Youtube',
        image: "assets/images/Putih-12.png",
        url: "com.google.android.youtube.tv"),
    MenuModel(
        title: 'Youtube Kids', image: "assets/images/Putih-11.png", url: ""),
    MenuModel(
        title: 'Netflix',
        image: "assets/images/Putih-10.png",
        url: "com.netflix.mediaclient"),
    MenuModel(
        title: 'Spotify',
        image: "assets/images/Putih-09.png",
        url: "com.spotify.music"),
    MenuModel(
        title: 'Info',
        image: "assets/images/Putih-08.png",
        url: InfoPage.routeName,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(8, 1, 0, 0.5),
                  ),
                  child: ListView.separated(
                    itemCount: menuModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return menuCard(menuModel[index]);
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

  Widget menuCard(MenuModel menuData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              if (menuData.type != null && menuData.type == 'inApp') {
                Navigator.pushNamed(context, menuData.url!,
                    arguments: InfoArguments(_deviceId!));
              } else {
                await LaunchApp.openApp(
                    androidPackageName: menuData.url, openStore: false);
              }
            },
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
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
                  (Set<MaterialState> states) {
                return const EdgeInsets.symmetric(horizontal: 15);
              }),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 60,
              width: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(menuData.image!))),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              menuData.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
