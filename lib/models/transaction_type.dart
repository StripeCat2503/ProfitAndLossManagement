import 'dart:convert';

TransactionType transactionTypeFromJson(String str) =>
    TransactionType.fromJson(json.decode(str));

String transactionTypeToJson(TransactionType data) =>
    json.encode(data.toJson());

class TransactionType {
  TransactionType({
    this.name,
    this.code,
    this.isDebit,
    this.transactions,
    this.id,
    this.modifiedDate,
    this.createdDate,
    this.actived,
  });

  String name;
  String code;
  bool isDebit;
  dynamic transactions;
  String id;
  DateTime modifiedDate;
  DateTime createdDate;
  bool actived;

  factory TransactionType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TransactionType(
      name: json["name"],
      code: json["code"],
      isDebit: json["is-debit"] != null ?? false,
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "is-debit": isDebit,
        "transactions": transactions,
        "id": id,
        "modified-date": modifiedDate.toIso8601String(),
        "created-date": createdDate.toIso8601String(),
        "actived": actived,
      };
}
