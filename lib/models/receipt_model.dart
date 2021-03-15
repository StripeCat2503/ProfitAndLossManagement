import 'dart:convert';

class Receipt {
  Receipt({this.description, this.id});
  String id;
  String description;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      Receipt(description: json["description"], id: json["id"]);

  Map<String, dynamic> toJson() => {"description": description, "id": id};
}
