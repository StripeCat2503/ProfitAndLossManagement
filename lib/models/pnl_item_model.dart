class PnlItemModel {
  PnlItemModel({
    this.name,
    this.balance,
    this.account,
  });

  String name;
  double balance;
  String account;

  factory PnlItemModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return PnlItemModel(
      name: json["name"],
      balance: json["balance"] == null ? 0 : json["balance"].toDouble(),
      account: json["account"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "balance": balance,
        "account": account,
      };
}
