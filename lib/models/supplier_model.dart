import 'dart:convert';

Supplier transactionTypeFromJson(String str) =>
    Supplier.fromJson(json.decode(str));

String transactionTypeToJson(Supplier data) => json.encode(data.toJson());

class Supplier {
  Supplier({
    this.name,
    this.address,
    this.phone,
    this.email,
    this.id,
  });

  String name;
  dynamic address;
  dynamic phone;
  dynamic email;
  String id;

  factory Supplier.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Supplier(
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      email: json["email"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "id": id,
      };
}
