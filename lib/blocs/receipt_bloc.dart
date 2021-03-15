import 'dart:async';

import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/search_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

class ReceiptBloc {
  final _controller =
      StreamController<List<ReceiptNew>>(); // Khai báo Stream // quan ly
  final ReceiptNewRepository _provider = ReceiptNewRepository();
  Stream<List<ReceiptNew>> get lstReceipts =>
      _controller.stream; //get steam đưa dữ liệu
  List<ReceiptNew> _listReceipt;
  List<ReceiptNew> get listReceipts => _listReceipt;
  Future loadTransaction(SearchModel search) async {
    var prefs = await SharedPreferences.getInstance();
    var userLogin =
        TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
    String storeId = '';
    if (userLogin != null && userLogin.role.toLowerCase() == 'memberinstore') {
      storeId = userLogin.store.id;
    }
    search.storeId = storeId;
    _listReceipt =
        await _provider.searchReceipts(search.toJson()); // goi api lay du lieu
    if (_listReceipt != null) {
      _controller.sink.add(_listReceipt); // add vô stream ra. Sink là add
    }
  }

  void dispose() {
    // TODO: implement dispose
    _controller.close();
  }
}
