import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pnL/models/evidence_model.dart';
import 'package:pnL/models/page_result.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/resources/api_base.dart';
import '../models/api_response_model.dart';
import 'dart:convert';

class EvidenceRepository {
  ApiBase apiBase = ApiBase();
  final String apiEndPoint = 'evidences';

  Future createEvidence(String receiptId, List<File> lstImage) async {
    Uri addressUri = Uri.parse(apiBase.getApiUrl() + apiEndPoint);
    lstImage.forEach((image) async {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

      // Intilize the multipart request
      final imageUploadRequest = http.MultipartRequest('POST', addressUri);

      // Attach the file in the request
      final file = await http.MultipartFile.fromPath('image', image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

      imageUploadRequest.files.add(file);
      imageUploadRequest.fields['receipt-id'] = receiptId;

      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 200) {
        } else {
          ApiResponseModel responseData =
              ApiResponseModel.fromJson(json.decode(response.body));
        }
      } catch (e) {
        print(e);
      }
    });
  }

  Future<List<Evidence>> getListEvidenceByReceipt(
      String receiptId, String token) async {
    var queryParam = {
      'receipt-id': receiptId,
    };
    try {
      var uri = Uri.http(
          apiBase.apiDomain, apiBase.apiSubDomain + apiEndPoint, queryParam);
      Map<String, String> headers = {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      ApiResponseModel response =
          await apiBase.fetchData(uri, 'get', headers, {});
      if (response != null) {
        List<Evidence> listEvidence = [];
        PageResultModel pageResult =
            PageResultModel.fromJson(response.results.results[0]);
        pageResult.data.forEach((element) {
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
