import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pnL/models/api_result_model.dart';
import 'package:pnL/models/evidence_model.dart';
import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/models/search_pnl_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/resources/api_base.dart';
import '../models/api_response_model.dart';
import 'dart:convert' as json;

class DashboardRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'dashboards/mobile/profit-and-loss';

  Future<ProfitAndLossViewModel> getPnl(
      SearchPnlModel searchModel, String token) async {
    try {
      var uri = Uri.http(apiBase.apiDomain, apiBase.apiSubDomain + apiEndPoint,
          searchModel.toJson());
      Map<String, String> headers = {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var responseModel = await http.get(uri, headers: headers);
      ApiResponseModel response =
          ApiResponseModel.fromJson(json.jsonDecode(responseModel.body));
      if (response != null) {
        ProfitAndLossViewModel pnl =
            ProfitAndLossViewModel.fromJson(response.results.results[0]);
        return pnl;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
