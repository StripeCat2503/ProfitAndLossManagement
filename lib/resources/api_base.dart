import 'package:http/http.dart' show Client, Response;
import 'dart:convert' show json;
import 'package:pnL/models/api_response_model.dart';

class ApiBase {
  Client _client = Client();
  final apiProtocol = 'https://';
  // final apiDomain = '192.168.1.180:45455';
  final apiDomain = 'pnl-retail.azurewebsites.net';
  final apiSubDomain = '/api/v1/';
  String apiUrl = '';
  String getApiUrl() {
    apiUrl = '$apiProtocol$apiDomain$apiSubDomain';
    return apiUrl;
  }

  Future<ApiResponseModel> fetchData(dynamic api, String method,
      Map<String, String> header, Map<String, dynamic> body) async {
    Response response;
    apiUrl = '$apiProtocol$apiDomain$apiSubDomain';
    if (method.compareTo('get') == 0) {
      response = await _client.get('$apiUrl$api', headers: header);
    } else if (method.compareTo('post') == 0) {
      var data = json.encode(body);
      response = await _client.post('$apiUrl$api', headers: header, body: data);
    } else if (method.compareTo('put') == 0) {
      response = await _client.put('$apiUrl$api', headers: header, body: body);
    } else if (method.compareTo('patch') == 0) {
      response =
          await _client.patch('$apiUrl$api', headers: header, body: body);
    }
    if (response.statusCode == 200) {
      print('Status code is 200');
      return ApiResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to call api');
    }
  }
}
