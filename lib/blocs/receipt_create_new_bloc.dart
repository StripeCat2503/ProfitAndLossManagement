import 'dart:async';
import 'dart:io';

import 'package:pnL/models/TransactionTypeConstant.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/transaction_type.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/evidence_repository.dart';
import 'package:pnL/repositories/supplier_repository.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:pnL/repositories/transaction_category_new_repository.dart';
import 'package:pnL/views/transactions/transaction_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

class ReceiptCreateNewBloc {
  final _supplier = StreamController<List<Supplier>>();
  final ReceiptNewRepository _provider = ReceiptNewRepository();
  final SupplierRepository _supplierRepository = SupplierRepository();
  final TransactionCategoryNewRepository _transactionCategoryNewRepository =
      TransactionCategoryNewRepository();
  final EvidenceRepository _evidenceRepository = EvidenceRepository();
  Stream<List<Supplier>> get lstSupplier =>
      _supplier.stream; //get steam đưa dữ liệu
  final _result = StreamController<String>();
  Stream<String> get result => _result.stream;
  List<Supplier> _listSupplier;
  TransactionType _transactionType =
      new TransactionType(id: 'c1684003-c94f-4c7e-af92-5fc31c4efa48');

  // transaction  cate
  Stream<List<TransactionCategory>> get listTransationCates =>
      _transactionCateController.stream; //get steam đưa dữ liệu
  final _transactionCateController =
      StreamController<List<TransactionCategory>>();
  Future initReceipt(bool isDebit) async {
    await _supplierRepository.getListSuppliers().then((value) => {
          if (value != null) {_supplier.sink.add(value)}
        });
    await _transactionCategoryNewRepository
        .getTransactionCategoryByTypeCode(isDebit)
        .then((value) => {
              if (value != null) {_transactionCateController.sink.add(value)}
            });
  }

  Future createExpenseTransaction(
      Supplier _supplier, ReceiptNew _transaction, List<File> lstImage) async {
    _transaction.supplier = _supplier;
    var prefs = await SharedPreferences.getInstance();
    var userLogin =
        TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
    _transaction.store = userLogin.store;
    var jsonModel = _transaction.toCreateJson();
    var result =
        await _provider.createNewReceipt(jsonModel, userLogin.accessToken);
    if (!(result?.id == null ?? true)) {
      if (result.id != null && lstImage.length > 0) {
        var temp =
            await _evidenceRepository.createEvidence(result.id, lstImage);
      }
      _result.sink.add("success");
    } else {
      _result.sink.add("failed");
    }
  }

  Future createIncomeReceipt(ReceiptNew _receipt, List<File> lstImage) async {
    var prefs = await SharedPreferences.getInstance();
    var userLogin =
        TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
    _receipt.store = userLogin.store;
    var jsonModel = _receipt.toCreateJson();
    var result =
        await _provider.createNewReceipt(jsonModel, userLogin.accessToken);
    if (!(result?.id == null ?? true)) {
      if (lstImage.length > 0) {
        var temp =
            await _evidenceRepository.createEvidence(result.id, lstImage);
      }
      _result.sink.add("success");
    } else {
      _result.sink.add("failed");
    }
  }

  void dispose() {
    // TODO: implement dispose
    _supplier.close();
    _result.close();
  }
}
