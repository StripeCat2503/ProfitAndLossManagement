import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/resources/api_base.dart';
import 'dart:convert';
import '../models/api_response_model.dart';

class TransactionCategoryNewRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'transaction-categories';
  final String search = '/search';
  final String getByTypeCode = '/type';

  Future<List<ReceiptNew>> searchReceipts(Map<String, dynamic> data) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };
    try {
      ApiResponseModel response =
          await apiBase.fetchData('$apiEndPoint$search', 'post', headers, data);
      if (response != null) {
        List<ReceiptNew> listReceipt = [];
        PageResultModel pageResult =
            PageResultModel.fromJson(response.results.results[0]);
        pageResult.data.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          ReceiptNew receiptModel = ReceiptNew.fromJson(elementMap);
          listReceipt.add(receiptModel);
        });
        return listReceipt;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<TransactionCategory>> getTransactionCategoryByTypeCode(
      bool isDebit) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };
    var url = r'' + apiEndPoint + getByTypeCode + r'/';
    if (isDebit)
      url += r'true';
    else
      url += r'false';
    try {
      ApiResponseModel response =
          await apiBase.fetchData(url, 'get', headers, {});
      if (response != null) {
        List<TransactionCategory> listTransactionCategories = [];
        response.results.results.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          TransactionCategory transactionCategoryModel =
              TransactionCategory.fromJson(elementMap);
          listTransactionCategories.add(transactionCategoryModel);
        });
        return listTransactionCategories;
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
