import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/resources/api_base.dart';
import 'dart:convert';
import '../models/api_response_model.dart';

class TransactionDetailRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'transactions';
  final String search = '/search';

  Future<List<Transaction>> fetchListTransaction(
      Map<String, dynamic> data) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };
    try {
      ApiResponseModel response =
          await apiBase.fetchData('$apiEndPoint$search', 'post', headers, data);
      if (response != null) {
        List<Transaction> listTransaction = [];
        PageResultModel pageResult =
            PageResultModel.fromJson(response.results.results[0]);
        pageResult.data.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          Transaction transactionModel = Transaction.fromJson(elementMap);
          listTransaction.add(transactionModel);
        });
        return listTransaction;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Transaction> createTransaction(
      Map<String, dynamic> data, String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      ApiResponseModel response =
          await apiBase.fetchData(apiEndPoint, 'post', headers, data);
      if (response != null) {
        return Transaction.fromJson(response.results.results[0]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Transaction> getTransactionById(
      String transactionId, String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      ApiResponseModel response = await apiBase
          .fetchData('$apiEndPoint/$transactionId', 'get', headers, {});
      if (response != null) {
        Transaction transaction =
            Transaction.fromJson(response.results.results[0]);
        return transaction;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
