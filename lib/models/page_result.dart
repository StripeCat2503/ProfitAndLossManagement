import 'dart:convert';

class PageResultModel {
  String statusCode;
  List<Map<String, dynamic>> data;
  int pageIndex;
  int totalCount;
  String message;
  int code;

  PageResultModel.fromJson(Map<String, dynamic> json) {
    data = _toJSon(json['data']);
    totalCount = json['total-count'];
    pageIndex = json['page-index'];
    code = json['code'];
  }
  List<Map<String, dynamic>> _toJSon(dynamic json) {
    var listResult = new List<Map<String, dynamic>>();
    var jsonData = json as List;
    jsonData.forEach((element) {
      listResult.add(element);
    });
    return listResult;
  }
}
