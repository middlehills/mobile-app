import 'dart:convert';
import 'dart:io';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:mid_hill_cash_flow/features/home/data/upload_model.dart';

class UploadApiFunctions {
  UploadApiFunctions._();

  static Future<ApiResponse> addSingleRecord({
    required String baseUrl,
    required UploadModel uploadData,
  }) async {
    final url = Uri.parse('${baseUrl}api/transaction/add/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(uploadData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Saved transaction successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to save transaction',
          data: jsonDecode(response.body),
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      }
    } on SocketException {
      return ApiResponse(
        message: 'No Internet connection.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } on FormatException {
      return ApiResponse(
        message: 'Unable to parse response.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } on HttpException {
      return ApiResponse(
        message: 'Could not find the server.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } catch (e) {
      return ApiResponse(
        message: 'Error occurred: $e',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    }
  }

  static Future<ApiResponse> addMultipleRecords({
    required String baseUrl,
    required List<UploadModel> uploadDataList,
  }) async {
    final url = Uri.parse('${baseUrl}api/transaction/add/');
    try {
      final body = jsonEncode(
        uploadDataList.map((e) => e.toJson()).toList(),
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Saved transactions successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to save transactions',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      }
    } on SocketException {
      return ApiResponse(
        message: 'No Internet connection.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } on FormatException {
      return ApiResponse(
        message: 'Unable to parse response.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } on HttpException {
      return ApiResponse(
        message: 'Could not find the server.',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    } catch (e) {
      return ApiResponse(
        message: 'Error occurred: $e',
        data: null,
        statusCode: null,
        responsePhrase: '',
      );
    }
  }
}
