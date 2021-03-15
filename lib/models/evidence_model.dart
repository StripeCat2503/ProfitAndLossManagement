// To parse this JSON data, do
//
//     final evidence = evidenceFromJson(jsonString);

import 'dart:convert';

Evidence evidenceFromJson(String str) => Evidence.fromJson(json.decode(str));

String evidenceToJson(Evidence data) => json.encode(data.toJson());

class Evidence {
  Evidence({
    this.name,
    this.description,
    this.imgUrl,
    this.receiptId,
    this.id,
    this.modifiedDate,
    this.createdDate,
    this.actived,
  });

  String name;
  String description;
  String imgUrl;
  String receiptId;
  String id;
  DateTime modifiedDate;
  DateTime createdDate;
  bool actived;

  factory Evidence.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _createdDate = null;
    DateTime _modifiedDate = null;
    try {
      _createdDate = DateTime.parse(json["created-date"]);
      _modifiedDate = DateTime.parse(json["modified-date"]);
    } catch (e) {}
    return Evidence(
      name: json["name"],
      description: json["description"],
      imgUrl: json["img-url"],
      receiptId: json["receipt-id"],
      id: json["id"],
      modifiedDate: _modifiedDate,
      createdDate: _createdDate,
      actived: json["actived"] == null ? false : json["actived"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "img-url": imgUrl,
        "receipt-id": receiptId,
      };
}
