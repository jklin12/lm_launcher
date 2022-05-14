import 'package:flutter/material.dart';

class ManagerGreeting extends StatelessWidget {
  const ManagerGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "GREETING FROM US",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 550,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
