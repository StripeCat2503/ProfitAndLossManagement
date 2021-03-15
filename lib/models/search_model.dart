// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.transactionTypeId,
    this.storeId,
    this.status,
    this.code,
    this.fromDate,
    this.toDate,
    this.page,
    this.pageSize,
    this.sortBy,
  });

  String transactionTypeId;
  String storeId;
  int status;
  String code;
  DateTime fromDate;
  DateTime toDate;
  int page;
  int pageSize;
  String sortBy;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        transactionTypeId: json["transaction-type-id"],
        storeId: json["store-id"],
        status: json["status"],
        code: json["code"],
        fromDate: DateTime.parse(json["from-date"]),
        toDate: DateTime.parse(json["to-date"]),
        page: json["page"],
        pageSize: json["page-size"],
        sortBy: json["sort-by"],
      );

  Map<String, dynamic> toJson() => {
        "transaction-type-id": transactionTypeId,
        "store-id": storeId,
        "status": status,
        "code": code,
        "from-date": fromDate == null ? '' : fromDate.toIso8601String(),
        "to-date": toDate == null ? '' : toDate.toIso8601String(),
        "page": page,
        "page-size": pageSize,
        "sort-by": sortBy,
      };
}
