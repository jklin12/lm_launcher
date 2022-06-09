import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lm_launcher/pages/resto_page.dart'; 
import 'package:lm_launcher/pages/home_page_new.dart';
import 'package:lm_launcher/pages/info_page_new.dart';
import 'package:lm_launcher/pages/info_pages.dart';
import 'package:lm_launcher/pages/radio_page.dart'; 
import 'package:lm_launcher/pages/tv_pages.dart';
import 'package:lm_launcher/pages/tvchannel_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Roboto Condensed',
                fontWeight: FontWeight.w700),
            bodyText1:
                TextStyle(fontSize: 15.0, fontFamily: 'Roboto Condensed'),
          ),
        ),
        initialRoute: '/',
        routes: {
          InfoPage.routeName: (context) => const InfoPageNew(),
          '/tv': (context) => const TvPages(),
          '/radio': (context) => const RadioPage(),
          '/resto': (context) => const RestoPages(),
        },
        home: const HomePageNew());
  }
}
