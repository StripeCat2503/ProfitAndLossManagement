import 'dart:convert';

import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/member.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/transaction_type.dart';

import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.id,
    this.description,
    this.balance,
    this.transactionCategory,
    this.store,
    this.accountingPeriod,
  });

  String id;
  String description;
  double balance;
  TransactionCategory transactionCategory;
  Store store;
  AccountingPeriod accountingPeriod;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Transaction(
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
