// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.baseUrl,
    this.data,
  });

  bool? status;
  String? message;
  String? baseUrl;
  Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        baseUrl: json["base_url"],
        //data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "base_url": baseUrl,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.tvId,
    this.tvIp,
    this.tvName,
    this.tvRoom,
    this.tvBackground,
    this.tvTextInfo,
    this.token,
  });

  String? tvId;
  String? tvIp;
  String? tvName;
  String? tvRoom;
  String? tvBackground;
  String? tvTextInfo;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tvId: json["tv_id"],
        tvIp: json["tv_ip"],
        tvName: json["tv_name"],
        tvRoom: json["tv_room"],
        tvBackground: json["tv_background"],
        tvTextInfo: json["tv_text_info"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "tv_id": tvId,
        "tv_ip": tvIp,
        "tv_name": tvName,
        "tv_room": tvRoom,
        "tv_background": tvBackground,
        "tv_text_info": tvTextInfo,
        "token": token,
      };
}
