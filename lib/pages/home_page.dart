import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lm_launcher/model/menu_model.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:lm_launcher/utils/InfoArguments.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:device_apps/device_apps.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _deviceId;
  bool? isHover = false;
  int? menuIndex = 0;

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
        url: "",
        node: FocusNode()),
    MenuModel(
        title: 'Netflix',
        image: "assets/images/Putih-10.png",
        url: "com.netflix.ninja",
        node: FocusNode()),
    MenuModel(
        title: 'Spotify',
        image: "assets/images/Putih-09.png",
        url: "com.spotify.music",
        node: FocusNode()),
    MenuModel(
        title: 'Info',
        image: "assets/images/Putih-08.png",
        url: InfoPage.routeName,
        type: 'inApp',
        node: FocusNode()),
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
    getApps();
  }

  getApps() async {
    // Returns a list of only those apps that have launch intent
List<Application> apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeSystemApps: true);
    for (var element in apps) {
      print(element.packageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM kk:mm').format(now);
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
                          Image.asset("assets/images/logo.png",height: 25,),
                          Text(
                            formattedDate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed',color: Colors.white),
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
                          const Text(
                            "Welcome Room 132",
                            textAlign: TextAlign.center,
                            style:   TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed',color: Colors.white)
                          ),
                          Text(
                            "TV ID : " + (_deviceId ?? '').toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed',color: Colors.white)
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
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(8, 1, 0, 0.5),
                  ),
                  child: ListView.separated(
                    itemCount: menuModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RawKeyboardListener(
                          onKey: ((RawKeyEvent event) async {
                            if (event.isKeyPressed(LogicalKeyboardKey.select)) { 
                              if (menuModel[menuIndex ?? 0].type != null &&
                                  menuModel[menuIndex ?? 0].type == 'inApp') {
                                Navigator.pushNamed(
                                    context, menuModel[menuIndex ?? 0].url!,
                                    arguments: InfoArguments(_deviceId!));
                              } else {
                                if (menuModel[menuIndex ?? 0].url != null ||
                                    menuModel[menuIndex ?? 0].url != '') {
                                  DeviceApps.openApp(
                                      menuModel[menuIndex!].url!);
                                }
                              }
                            }
                          }),
                          focusNode: menuModel[index].node ?? FocusNode(),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () => false,
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(
                                              MaterialState.focused) ||
                                          states.contains(
                                              MaterialState.pressed)) {
                                        menuIndex = index;
                                        return const Color(0XFF007BF9)
                                            .withOpacity(0.8);
                                      }
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
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
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 50,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              menuModel[index].image!))),
                                ),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  (menuModel[index].title!).toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const  TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed',color: Colors.white)
                                ),
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
              ),
            ),
               const Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 31.5,
              child: Divider(
                
                color: Colors.blue,
                thickness: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleKey(RawKeyEvent key) {
    print("Event runtimeType is ${key.runtimeType}");
    if (key.runtimeType.toString() == 'RawKeyDownEvent') {
      RawKeyEventDataAndroid data = key.data as RawKeyEventDataAndroid;
      String _keyCode;
      _keyCode = data.keyCode.toString(); //keycode of key event (66 is return)

      print("why does this run twice $_keyCode");
    }
  }
}
