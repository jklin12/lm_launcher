// To parse this JSON data, do
//
//     final restoModel = restoModelFromJson(jsonString);

import 'dart:convert';

List<RestoModel> restoModelFromJson(String str) => List<RestoModel>.from(json.decode(str).map((x) => RestoModel.fromJson(x)));

String restoModelToJson(List<RestoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestoModel {
    RestoModel({
        this.title,
        this.image,
        this.food,
    });

    String? title;
    String? image;
    List<Food>? food;

    factory RestoModel.fromJson(Map<String, dynamic> json) => RestoModel(
        title: json["title"],
        image: json["image"],
        food: List<Food>.from(json["food"].map((x) => Food.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "food": List<dynamic>.from(food!.map((x) => x.toJson())),
    };
}

class Food {
    Food({
        this.title,
        this.body,
        this.image,
        this.datas,
    });

    String? title;
    String? body;
    String? image;
    List<String>? datas;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        title: json["title"],
        body: json["body"],
        image: json["image"],
        datas: List<String>.from(json["datas"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "datas": List<dynamic>.from(datas!.map((x) => x)),
    };
}
