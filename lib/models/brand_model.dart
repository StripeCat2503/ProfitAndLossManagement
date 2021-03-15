class Brand {
  Brand({
    this.code,
    this.name,
    this.id,
  });

  String code;
  String name;
  String id;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        code: json["code"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name == null ? null : name,
        "id": id,
      };
}
