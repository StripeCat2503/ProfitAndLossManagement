import 'package:pnL/models/brand_model.dart';

class Store {
  Store({
    this.code,
    this.name,
    this.brand,
    this.id,
  });

  String code;
  String name;
  Brand brand;
  String id;

  factory Store.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Store(
      code: json["code"],
      name: json["name"] == null ? null : json["name"],
      brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name == null ? null : name,
        "brand": brand == null ? null : brand.toJson(),
        "id": id,
      };
}
