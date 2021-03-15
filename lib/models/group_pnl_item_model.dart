import 'package:pnL/models/pnl_item_model.dart';

class GroupPnlItemModel {
  GroupPnlItemModel({
    this.title,
    this.endTitle,
    this.totalAmount,
    this.listCategory,
  });

  String title;
  String endTitle;
  double totalAmount;
  List<PnlItemModel> listCategory;

  factory GroupPnlItemModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return GroupPnlItemModel(
      title: json["title"],
      endTitle: json["end-title"],
      totalAmount: json["total-amount"],
      listCategory: json["list-category"] == null
          ? new List<PnlItemModel>()
          : List<PnlItemModel>.from(
              json["list-category"].map((x) => PnlItemModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "end-title": endTitle,
        "total-amount": totalAmount,
        "list-category":
            List<dynamic>.from(listCategory.map((x) => x.toJson())),
      };
}
