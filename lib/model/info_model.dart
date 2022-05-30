// To parse this JSON data, do
//
//     final infoModel = infoModelFromJson(jsonString);

import 'dart:convert';

List<InfoModel> infoModelFromJson(String str) =>
    List<InfoModel>.from(json.decode(str).map((x) => InfoModel.fromJson(x)));

String infoModelToJson(List<InfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoModel {
  InfoModel({
    this.title,
    this.image,
  });

  String? title;
  String? image;

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
      };
}
