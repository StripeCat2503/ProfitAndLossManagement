import 'dart:async';

import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/accouting_period_repository.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

class AccountingPeriodBloc {
  final _controller =
      StreamController<List<AccountingPeriod>>(); // Khai báo Stream // quan ly

  final AccountingPeriodRepository _provider = AccountingPeriodRepository();
  
  Stream<List<AccountingPeriod>> get lstAccoutingPeriod =>
      _controller.stream; //get steam đưa dữ liệu
  List<AccountingPeriod> _listAccountingPeriod;
  List<AccountingPeriod> get listReceipts => _listAccountingPeriod;
  Future loadAccountingPeriod() async {
    var prefs = await SharedPreferences.getInstance();
    var userLogin =
        TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
    _listAccountingPeriod = await _provider
        .getListAccoutingPeriod(userLogin?.accessToken); // goi api lay du lieu
    if (_listAccountingPeriod != null) {
      _controller.sink
          .add(_listAccountingPeriod); // add vô stream ra. Sink là add
    }
  }

  void dispose() {
    // TODO: implement dispose
    _controller.close();
  }
}
