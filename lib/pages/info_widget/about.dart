import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "About Us",
                style:
                    TextStyle(fontSize: 18.0, fontFamily: 'Roboto Condensed'),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 350,
                child: Text(
                  "Aston Batam Hotel & Residence merupakan hotel baru di Batam dan hotel bintang empat yang terletak di pusat Batam, kota dimana bisnis dan hiburan menyatu dalam harmoni. Hotel ini terletak hanya 25 menit dari Bandara Hang Nadim dan hanya 8 menit dari Terminal Feri Harbour Bay, Pusat Perbelanjaan, Lapangan Golf menjadikannya salah satu pusat perdagangan paling strategis di Indonesia.",
                  textAlign: TextAlign.justify,
                  style:
                      TextStyle(fontSize: 15.0, fontFamily: 'Roboto Condensed'),
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
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  "https://media-cdn.tripadvisor.com/media/photo-s/10/63/9f/78/getlstd-property-photo.jpg"),
              fit: BoxFit.cover,
            )),
          ),
        )
      ],
    );
  }
}
