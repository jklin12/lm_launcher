import 'package:flutter/material.dart';
import 'package:lm_launcher/model/about_model.dart';

class AboutUs extends StatelessWidget {
  final AboutModel? aboutModel;

  const AboutUs({Key? key, this.aboutModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aboutModel!.title!,
                style: const TextStyle(
                    fontSize: 18.0, fontFamily: 'Roboto Condensed'),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 350,
                child: Text(
                  aboutModel!.body!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 15.0, fontFamily: 'Roboto Condensed'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150.0,
            height: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
              image:
                  NetworkImage('http://202.169.224.46/lm_launcher/' + aboutModel!.image!),
              fit: BoxFit.cover,
            )),
          ),
        )
      ],
    );
  }
}
