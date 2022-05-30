// To parse this JSON data, do
//
//     final radioModel = radioModelFromJson(jsonString);

import 'dart:convert';

List<RadioModel> radioModelFromJson(String str) =>
    List<RadioModel>.from(json.decode(str).map((x) => RadioModel.fromJson(x)));

String radioModelToJson(List<RadioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RadioModel {
  RadioModel({
    this.id,
    this.title,
    this.logo,
    this.streamUrl,
    this.favorite,
  });

  int? id;
  String? title;
  String? logo;
  String? streamUrl;
  int? favorite;

  factory RadioModel.fromJson(Map<String, dynamic> json) => RadioModel(
        id: json["id"],
        title: json["title"],
        logo: json["logo"],
        streamUrl: json["streamUrl"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "logo": logo,
        "streamUrl": streamUrl,
        "favorite": favorite,
      };
}
