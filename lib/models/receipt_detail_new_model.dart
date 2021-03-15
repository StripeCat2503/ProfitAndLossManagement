import 'dart:convert';

import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/transaction_category_model.dart';

class ReceiptDetailNew {
  ReceiptDetailNew({
    this.id,
    this.description,
    this.balance,
    this.transactionCategory,
    this.store,
    this.accountingPeriod,
  });

  String id;
  String description;
  int balance;
  TransactionCategory transactionCategory;
  Store store;
  AccountingPeriod accountingPeriod;

  factory ReceiptDetailNew.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ReceiptDetailNew(
      id: json["id"],
      description: json["description"],
      balance: json["balance"],
      transactionCategory:
          TransactionCategory.fromJson(json["transaction-category"]),
      store: Store.fromJson(json["store"]),
      accountingPeriod: AccountingPeriod.fromJson(json["accounting-period"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "balance": balance,
        "transaction-category": transactionCategory.toJson(),
        "store": store.toJson(),
        "accounting-period": accountingPeriod.toJson(),
      };
}

class TransactionDetail {
  TransactionDetail({
    this.id,
    this.description,
    this.balance,
    this.transactionCategory,
    this.store,
  });

  String id;
  String description;
  double balance;
  TransactionCategory transactionCategory;
  Store store;

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _createdDate = null;
    DateTime _modifiedDate = null;
    try {
      _createdDate = DateTime.parse(json["created-date"]);
      _modifiedDate = DateTime.parse(json["modified-date"]);
    } catch (e) {}
    return TransactionDetail(
      id: json["id"],
      description: json["description"],
      balance: json["balance"] == null ? 0 : json["balance"],
      transactionCategory:
          TransactionCategory.fromJson(json["transaction-category"]),
      store: Store.fromJson(json["store"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "balance": balance,
        "transaction-category": transactionCategory.toJson(),
        "store": store.toJson(),
      };
}
