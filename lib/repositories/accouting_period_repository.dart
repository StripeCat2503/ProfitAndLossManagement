import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/evidence_model.dart';
import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/resources/api_base.dart';
import '../models/api_response_model.dart';
import 'dart:convert';

class AccountingPeriodRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'accounting-periods';

  Future<List<AccountingPeriod>> getListAccoutingPeriod(String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      ApiResponseModel response =
          await apiBase.fetchData('$apiEndPoint', 'get', headers, {});
      if (response != null) {
        List<AccountingPeriod> listAccoutingPeriod = [];
        response.results.results.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          AccountingPeriod accountingPeriod =
              AccountingPeriod.fromJson(elementMap);
          listAccoutingPeriod.add(accountingPeriod);
        });
        return listAccoutingPeriod;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
