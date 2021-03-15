import 'dart:async';

import 'package:pnL/models/evidence_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/evidence_repository.dart';
import 'package:pnL/repositories/receipt_repository.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;

class ReceiptDetailBloc {
  var prefs;
  var userLogin;
  final _controller =
      StreamController<ReceiptNew>(); // Khai báo Stream // quan ly
  final ReceiptNewRepository _provider = ReceiptNewRepository();
  Stream<ReceiptNew> get receipt => _controller.stream; //get steam đưa dữ liệu
  Future initReceipt(String receiptId) async {
    try {
      prefs = await SharedPreferences.getInstance();
      userLogin =
          TokenLoginResponse.fromJson(json.jsonDecode(prefs.get('user')));
      var receipt =
          await _provider.getReceiptById(receiptId, userLogin.accessToken);
      var lstTransactionByReceipt;
      List<Evidence> lstEvidence;
      List<String> lstImages = new List<String>();
      if (receipt != null) {
        lstTransactionByReceipt = await _provider.getListTransactionByReceiptId(
            receiptId, userLogin.accessToken);
        if (lstTransactionByReceipt != null) {
          receipt.lstTransactionDetail = lstTransactionByReceipt;
        }
        if (receipt.id != null) {
          lstEvidence = await _provider.getListEvidenceByReceipt(
              receipt.id, userLogin.accessToken);
          if (lstEvidence != null) {
            lstEvidence.forEach((element) {
              lstImages.add(element.imgUrl);
            });
          }
        }
        receipt.listImage = lstImages;
        _controller.sink.add(receipt);
      }
    } catch (e) {
      print(e.message);
    }
  }

  void dispose() {
    // TODO: implement dispose
    _controller.close();
  }
}
