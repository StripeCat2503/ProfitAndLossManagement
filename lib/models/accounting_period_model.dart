class AccountingPeriod {
  AccountingPeriod({
    this.startDate,
    this.closeDate,
    this.brandId,
    this.title,
    this.description,
    this.status,
    this.accountingPeriodInStores,
    this.feedbacks,
    this.id,
    this.modifiedDate,
    this.createdDate,
    this.actived,
  });

  DateTime startDate;
  DateTime closeDate;
  String brandId;
  String title;
  String description;
  int status;
  List<dynamic> accountingPeriodInStores;
  List<dynamic> feedbacks;
  String id;
  DateTime modifiedDate;
  DateTime createdDate;
  bool actived;

  factory AccountingPeriod.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DateTime _createDate = null;
    DateTime _modifyDate = null;
    DateTime _startDate = null;
    DateTime _closeDate = null;
    try {
      _modifyDate = DateTime.parse(json["modified-date"]);
      _createDate = DateTime.parse(json["created-date"]);
      _startDate = DateTime.parse(json["start-date"]);
      _closeDate = DateTime.parse(json["close-date"]);
    } catch (e) {}
    return AccountingPeriod(
      startDate: _startDate,
      closeDate: _closeDate,
      brandId: json["brand-id"],
      title: json["title"],
      description: json["description"],
      status: json["status"] == null ? 0 : json["status"],
      id: json["id"],
      modifiedDate: _createDate,
      createdDate: _modifyDate,
      actived: json["actived"] == null ? false : json["actived"],
    );
  }

  Map<String, dynamic> toJson() {
    var _createDate = '';
    var _modifiedDate = '';
    var _startDate = '';
    var _closeDate = '';
    try {
      _startDate = startDate.toIso8601String();
      _closeDate = closeDate.toIso8601String();
      _createDate = createdDate.toIso8601String();
      _modifiedDate = modifiedDate.toIso8601String();
    } catch (e) {}
    return {
      "start-date": _startDate,
      "close-date": _closeDate,
      "brand-id": brandId,
      "title": title,
      "description": description,
      "status": status,
      "id": id,
      "modified-date": _modifiedDate,
      "created-date": _createDate,
      "actived": actived,
    };
  }
}
