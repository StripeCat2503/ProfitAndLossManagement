import 'dart:async';
import 'dart:io';

import 'package:pnL/models/TransactionTypeConstant.dart';
import 'package:pnL/models/pnl_model.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/search_pnl_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/transaction_type.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/dashboard_repository.dart';
import 'package:pnL/repositories/evidence_repository.dart';
import 'package:pnL/repositories/supplier_repository.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:pnL/views/transactions/transaction_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

class DashboardBloc {
  final _pnlModel = StreamController<ProfitAndLossViewModel>();
  final DashboardRepository _provider = DashboardRepository();
  Stream<ProfitAndLossViewModel> get profitAndLoss =>
      _pnlModel.stream; //get steam đưa dữ liệu
  final _result = StreamController<String>();
  Stream<String> get result => _result.stream;
  List<Supplier> _listSupplier;
  TransactionType _transactionType =
      new TransactionType(id: 'c1684003-c94f-4c7e-af92-5fc31c4efa48');
  Future initDashboard(String accountingPeriodId) async {
    var prefs = await SharedPreferences.getInstance();
    var userLogin =
        TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
    String storeId = '';
    if (userLogin != null && userLogin.role.toLowerCase() == 'memberinstore') {
      storeId = userLogin.store.id;
    }
    var searchModel = new SearchPnlModel(
        accountingPeriodId: accountingPeriodId, storeId: storeId);
    await _provider.getPnl(searchModel, userLogin.accessToken).then((value) => {
          if (value != null) {_pnlModel.sink.add(value)}
        });
  }

  void dispose() {
    // TODO: implement dispose
    _pnlModel.close();
    _result.close();
  }
}
