// To parse this JSON data, do
//
//     final facilitesModel = facilitesModelFromJson(jsonString);

import 'dart:convert';

Map<String, FacilitesModel> facilitesModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, FacilitesModel>(k, FacilitesModel.fromJson(v)));

String facilitesModelToJson(Map<String, FacilitesModel> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class FacilitesModel {
  FacilitesModel({
    this.title,
    this.nama,
    this.datas,
  });

  String? title;
  String? nama;
  List<String>? datas;

  factory FacilitesModel.fromJson(Map<String, dynamic> json) => FacilitesModel(
        title: json["title"],
        nama: json["nama"],
        datas: List<String>.from(json["datas"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "nama": nama,
        "datas": List<dynamic>.from(datas!.map((x) => x)),
      };
}
