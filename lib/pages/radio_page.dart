import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lm_launcher/model/radio_mode.dart';
import 'package:lm_launcher/pages/widget/radio_card.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  List<RadioModel> radioModel = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/radios-id.json');
    final data = await json.decode(response);
    setState(() {
      radioModel = (data as List).map((e) {
        return RadioModel.fromJson(e);
      }).toList();
      focusNodes = List<FocusNode>.generate(
          radioModel.length, (int index) => FocusNode());
      focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: radioModel.length,
          itemBuilder: (context, index) {
            return RadioCard(
              focusNode: focusNodes[index],
              title: radioModel[index].title,
              image: radioModel[index].logo,
              url: radioModel[index].logo,
            );
          }),
    );
  }
}
