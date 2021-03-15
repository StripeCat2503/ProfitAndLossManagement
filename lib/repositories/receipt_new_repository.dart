import 'package:pnL/models/evidence_model.dart';
import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/resources/api_base.dart';
import 'dart:convert';
import '../models/api_response_model.dart';

class ReceiptNewRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'receipts';
  final String search = '/search';

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

  Future<List<Transaction>> getListTransactionByReceiptId(
      String receiptId, String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = '$apiEndPoint/$receiptId/transactions';
    try {
      ApiResponseModel response =
          await apiBase.fetchData(url, 'get', headers, {});
      if (response != null) {
        List<Transaction> listTransaction = [];
        response.results.results.forEach((element) {
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

  Future<ReceiptNew> createNewReceipt(
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
        return ReceiptNew.fromJson(response.results.results[0]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ReceiptNew> getReceiptById(String receiptId, String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      ApiResponseModel response = await apiBase
          .fetchData('$apiEndPoint/$receiptId', 'get', headers, {});
      if (response != null) {
        ReceiptNew receipt = ReceiptNew.fromJson(response.results.results[0]);
        return receipt;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Evidence>> getListEvidenceByReceipt(
      String receiptId, String token) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = '$apiEndPoint/$receiptId/evidences';
    try {
      ApiResponseModel response =
          await apiBase.fetchData(url, 'get', headers, {});
      if (response != null) {
        List<Evidence> listEvidence = [];
        response.results.results.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          Evidence transactionModel = Evidence.fromJson(elementMap);
          listEvidence.add(transactionModel);
        });
        return listEvidence;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
