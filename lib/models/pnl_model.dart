import 'dart:convert';

import 'package:pnL/models/group_pnl_item_model.dart';

ProfitAndLossViewModel profitAndLossViewModelFromJson(String str) =>
    ProfitAndLossViewModel.fromJson(json.decode(str));

String profitAndLossViewModelToJson(ProfitAndLossViewModel data) =>
    json.encode(data.toJson());

class ProfitAndLossViewModel {
  ProfitAndLossViewModel({
    this.startedDate,
    this.closedDate,
    this.incomes,
    this.expenses,
    this.costOfGoodsSold,
    this.grossProfit,
    this.netProfit,
  });

  DateTime startedDate;
  DateTime closedDate;
  GroupPnlItemModel incomes;
  GroupPnlItemModel expenses;
  GroupPnlItemModel costOfGoodsSold;
  double grossProfit;
  double netProfit;

  factory ProfitAndLossViewModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _startedDate = null;
    DateTime _closedDate = null;
    try {
      _startedDate = DateTime.parse(json["started-date"]);
      _closedDate = DateTime.parse(json["closed-date"]);
    } catch (e) {}
    return ProfitAndLossViewModel(
      startedDate: _startedDate,
      closedDate: _closedDate,
      incomes: GroupPnlItemModel.fromJson(json["incomes"]),
      expenses: GroupPnlItemModel.fromJson(json["expenses"]),
      costOfGoodsSold: GroupPnlItemModel.fromJson(json["cost-of-goods-sold"]),
      grossProfit: json["gross-profit"],
      netProfit: json["net-profit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "started-date": startedDate.toIso8601String(),
        "closed-date": closedDate.toIso8601String(),
        "incomes": incomes.toJson(),
        "expenses": expenses,
        "income-expense": costOfGoodsSold,
        "gross-profit": grossProfit,
        "net-profit": netProfit,
      };
}
