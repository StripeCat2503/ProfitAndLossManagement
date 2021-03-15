import 'dart:convert';

SearchPnlModel searchModelFromJson(String str) =>
    SearchPnlModel.fromJson(json.decode(str));

String searchModelToJson(SearchPnlModel data) => json.encode(data.toJson());

class SearchPnlModel {
  SearchPnlModel({
    this.storeId,
    this.accountingPeriodId,
  });

  String storeId;
  String accountingPeriodId;

  factory SearchPnlModel.fromJson(Map<String, dynamic> json) => SearchPnlModel(
        storeId: json["store-id"],
        accountingPeriodId: json["accounting-period-id"],
      );

  Map<String, String> toJson() => {
        "store-id": storeId,
        "accounting-period-id": accountingPeriodId,
      };
}
