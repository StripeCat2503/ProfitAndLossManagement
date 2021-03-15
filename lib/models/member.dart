class Member {
  Member({
    this.username,
    this.firstName,
    this.phone,
    this.email,
    this.id,
  });

  String username;
  String firstName;
  dynamic phone;
  dynamic email;
  String id;

  factory Member.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Member(
      username: json["username"],
      firstName: json["first-name"],
      phone: json["phone"],
      email: json["email"],
      id: json["id"],
    );
  }
  Map<String, dynamic> toJson() => {
        "username": username,
        "first-name": firstName,
        "phone": phone,
        "email": email,
        "id": id,
      };
}
