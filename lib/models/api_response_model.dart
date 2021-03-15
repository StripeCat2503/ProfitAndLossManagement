import './api_result_model.dart';

class ApiResponseModel {
  ApiResultModel results;
  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    results = new ApiResultModel.fromJson(json);
  }
}
