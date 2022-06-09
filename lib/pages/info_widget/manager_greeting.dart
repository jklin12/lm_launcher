import 'package:flutter/material.dart';
import 'package:lm_launcher/model/about_model.dart';

class ManagerGreeting extends StatelessWidget {
  final AboutModel? managerModel;
  const ManagerGreeting({Key? key, this.managerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            managerModel!.title!,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Roboto Condensed',
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 500,
            child: Text(
              managerModel!.body!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Roboto Condensed',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
