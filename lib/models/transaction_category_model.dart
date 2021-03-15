import 'package:pnL/models/transaction_type.dart';

class TransactionCategory {
  TransactionCategory({
    this.code,
    this.name,
    this.description,
    this.transactionTypeId,
    this.transactionType,
    this.isDebit,
    this.transactionDetails,
    this.id,
    this.modifiedDate,
    this.createdDate,
    this.actived,
  });

  String code;
  String name;
  dynamic description;
  String transactionTypeId;
  TransactionType transactionType;
  bool isDebit;
  dynamic transactionDetails;
  String id;
  DateTime modifiedDate;
  DateTime createdDate;
  bool actived;

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _createdDate = null;
    DateTime _modifiedDate = null;
    try {
      _createdDate = DateTime.parse(json["created-date"]);
      _modifiedDate = DateTime.parse(json["modified-date"]);
    } catch (e) {}
    return TransactionCategory(
      code: json["code"],
      name: json["name"],
      description: json["description"],
      transactionTypeId: json["transaction-type-id"],
      transactionType: json["transaction-type"],
      isDebit: json["is-debit"],
      transactionDetails: json["transaction-details"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "description": description,
        "transaction-type-id": transactionTypeId,
        "transaction-type": transactionType,
        "is-debit": isDebit,
        "transaction-details": transactionDetails,
        "id": id,
        "modified-date": modifiedDate.toIso8601String(),
        "created-date": createdDate.toIso8601String(),
        "actived": actived,
      };
}
