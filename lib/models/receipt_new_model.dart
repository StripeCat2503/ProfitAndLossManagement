import 'dart:convert';

import 'package:pnL/models/member.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/transaction_type.dart';

ReceiptNew transactionFromJson(String str) =>
    ReceiptNew.fromJson(json.decode(str));

String transactionToJson(ReceiptNew data) => json.encode(data.toJson());

class ReceiptNew {
  ReceiptNew(
      {this.member,
      this.receiptType,
      this.name,
      this.code,
      this.totalBalance = 0,
      this.subTotal = 0,
      this.shippingFee = 0,
      this.discountPercent = 0,
      this.discountValue = 0,
      this.noteMessage,
      this.store,
      this.supplier,
      this.status,
      this.createdDate,
      this.modifiedDate,
      this.id,
      this.lstTransactionDetail,
      this.listImage,
      this.openDate,
      this.closeDate,
      this.category});

  Member member;
  TransactionType receiptType;
  String name;
  String code;
  double totalBalance = 0;
  double subTotal = 0;
  double shippingFee = 0;
  double discountPercent = 0;
  double discountValue = 0;
  double dueBalance = 0;
  String noteMessage;
  Store store;
  Supplier supplier;
  int status;
  DateTime createdDate;
  DateTime modifiedDate;
  DateTime openDate;
  DateTime closeDate;
  String id;
  String category;
  List<Transaction> lstTransactionDetail;
  List<String> listImage;

  factory ReceiptNew.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _createdDate = null;
    DateTime _modifiedDate = null;
    DateTime _openDate = null;
    DateTime _closeDate = null;
    try {
      _createdDate = DateTime.parse(json["created-date"]);
      _modifiedDate = DateTime.parse(json["modified-date"]);
      _openDate = DateTime.parse(json["open-date"]);
      _closeDate = DateTime.parse(json["close-date"]);
    } catch (e) {}
    return ReceiptNew(
        member: Member.fromJson(json["member"]),
        receiptType: TransactionType.fromJson(json["transaction-type"]),
        name: json["name"],
        code: json["code"],
        totalBalance: json["total-balance"],
        subTotal: json["sub-total"],
        shippingFee: json["shipping-fee"],
        discountPercent: json["discount-percent"],
        discountValue: json["discount-value"],
        noteMessage: json["note-message"],
        store: Store.fromJson(json["store"]),
        supplier: Supplier.fromJson(json["supplier"]),
        status: json["status"],
        createdDate: _createdDate,
        modifiedDate: _modifiedDate,
        openDate: _createdDate,
        closeDate: _modifiedDate,
        id: json["id"],
        lstTransactionDetail: new List<Transaction>(),
        listImage: new List<String>());
  }
  Map<String, dynamic> toCreateJson() {
    var _openDate = '';
    var _closeDate = '';
    try {
      _openDate = openDate.toIso8601String();
      _closeDate = closeDate.toIso8601String();
    } catch (e) {}
    return {
      "store-id": store?.id,
      "supplier-id": supplier?.id,
      "name": name,
      "total-balance": totalBalance,
      "shipping-fee": shippingFee,
      "discount-percent": discountPercent,
      "discount-value": discountValue,
      "note-message": noteMessage,
      "open-date": _openDate,
      "close-date": _closeDate,
      "category": category
    };
  }

  Map<String, dynamic> toJson() {
    var _createDate = '';
    var _modifiedDate = '';
    var _openDate = '';
    var _closeDate = '';
    try {
      _createDate = createdDate.toIso8601String();
      _modifiedDate = modifiedDate.toIso8601String();
      _openDate = openDate.toIso8601String();
      _closeDate = closeDate.toIso8601String();
    } catch (e) {}
    return {
      "member": member ?? member.toJson(),
      "transaction-type": receiptType ?? receiptType.toJson(),
      "name": name,
      "code": code,
      "total-balance": totalBalance,
      "sub-total": subTotal,
      "shipping-fee": shippingFee,
      "discount-percent": discountPercent,
      "discount-value": discountValue,
      "note-message": noteMessage,
      "store": store ?? store.toJson(),
      "supplier": supplier ?? supplier.toJson(),
      "status": status,
      "created-date": _createDate,
      "modified-date": _modifiedDate,
      "created-date": _openDate,
      "modified-date": _closeDate,
      "id": id,
    };
  }
}
