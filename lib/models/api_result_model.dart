class ApiResultModel {
  String statusCode;
  List<Map<String, dynamic>> results;
  List<Map<String, dynamic>> error;
  bool success;
  String message;
  int resultCode;

  ApiResultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'].toString();
    if (json['results'] is List) {
      results = List<Map<String, dynamic>>.from(json['results']);
    } else {
      results = new List<Map<String, dynamic>>();
      results.add(json['results']);
    }
    success = json['success'];
    message = json['message'];
    error = _toJSon(json['error']);
    resultCode = json['result-code'];
  }
  List<Map<String, dynamic>> _toJSon(dynamic json) {
    var listResult = new List<Map<String, dynamic>>();
    try {
      var jsonData = json as List;
      jsonData.forEach((element) {
        listResult.add(element);
      });
    } catch (e) {}
    return listResult;
  }
}
