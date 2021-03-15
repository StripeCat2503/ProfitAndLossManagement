import 'package:pnL/models/api_result_model.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/models/page_result.dart';
import 'package:pnL/resources/api_base.dart';
import 'package:pnL/resources/app_result_code.dart';
import 'package:pnL/validations/login_validation.dart';
import '../models/api_response_model.dart';

class UserRepository {
  ApiBase apiBase = ApiBase();
  final String loginEndpoint = 'users/login';

  Future<TokenLoginResponse> login(Map<String, dynamic> data) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };
    ApiResponseModel response =
        await apiBase.fetchData(loginEndpoint, 'post', headers, data);
    TokenLoginResponse userModel = new TokenLoginResponse();
    if (response != null) {
      ApiResultModel resultModel = response.results;
      if (resultModel.success) {
        userModel = TokenLoginResponse.fromJson(resultModel.results[0]);
      } else if (resultModel.resultCode == AppResultCode.FailValidation.index) {
        resultModel.error.forEach((element) {
          userModel.fromJsonToValidation(element);
        });
      }
    }
    return userModel;
  }
}
