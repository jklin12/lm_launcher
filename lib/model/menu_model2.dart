// To parse this JSON data, do
//
//     final menuModel2 = menuModel2FromJson(jsonString);

import 'dart:convert';

List<MenuModel2> menuModel2FromJson(String str) =>
    List<MenuModel2>.from(json.decode(str).map((x) => MenuModel2.fromJson(x)));

String menuModel2ToJson(List<MenuModel2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel2 {
  MenuModel2(
      {this.menuId,
      this.tvId,
      this.menuTitle,
      this.menuImage,
      this.menuUrl,
      this.menuType,
      this.menuImage2});

  String? menuId;
  String? tvId;
  String? menuTitle;
  String? menuImage;
  String? menuImage2;
  String? menuUrl;
  String? menuType;

  factory MenuModel2.fromJson(Map<String, dynamic> json) => MenuModel2(
        menuId: json["menu_id"],
        tvId: json["tv_id"],
        menuTitle: json["menu_title"],
        menuImage: json["menu_image"],
        menuImage2: json["menu_image2"],
        menuUrl: json["menu_url"],
        menuType: json["menu_type"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "tv_id": tvId,
        "menu_title": menuTitle,
        "menu_image": menuImage,
        "menu_image_2": menuImage2,
        "menu_url": menuUrl,
        "menu_type": menuType,
      };
}
