// To parse this JSON data, do
//
//     final channeModel = channeModelFromJson(jsonString);

import 'dart:convert';

List<ChanneModel> channeModelFromJson(String str) => List<ChanneModel>.from(json.decode(str).map((x) => ChanneModel.fromJson(x)));

String channeModelToJson(List<ChanneModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChanneModel {
    ChanneModel({
        this.name,
        this.logo,
        this.url,
    });

    String? name;
    String? logo;
    String? url;

    factory ChanneModel.fromJson(Map<String, dynamic> json) => ChanneModel(
        name: json["name"],
        logo: json["logo"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "url": url,
    };
}
