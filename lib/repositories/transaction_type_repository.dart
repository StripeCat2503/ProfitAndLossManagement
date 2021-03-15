import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/resources/api_base.dart';
import '../models/api_response_model.dart';

class TransactionTypeRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'transactiontypes';

  Future<List<Supplier>> getListSuppliers() async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };
    try {
      ApiResponseModel response =
          await apiBase.fetchData(apiEndPoint, 'get', headers, null);
      if (response != null) {
        List<Supplier> listSupplier = [];
        response.results.results.forEach((element) {
          var elementMap = Map<String, dynamic>.from(element);
          Supplier supplierModel = Supplier.fromJson(elementMap);
          listSupplier.add(supplierModel);
        });
        return listSupplier;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
