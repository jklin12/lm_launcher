import 'package:flutter/cupertino.dart';

class MenuModel {
  final String? title;
  final String? image;
  final String? url;
  final String? type;
  final FocusNode? node;

  MenuModel({this.title, this.image, this.url, this.type, this.node});
}
