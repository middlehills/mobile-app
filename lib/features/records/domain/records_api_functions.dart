import 'dart:convert';
import 'dart:io';
import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_service.dart';

class RecordsApiFunctions {
  RecordsApiFunctions._();

  static Future<ApiResponse> fetchTransactions({
    required String baseUrl,
    required String businessID,
  }) async {
    final url = Uri.parse('${baseUrl}api/transaction/get/');
    try {
      final accessToken = await AuthService.getAccessToken();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Fetched transactions successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to fetch transaction',
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

  static Future<ApiResponse> deleteTransaction({
    required String baseUrl,
    required String transactionId,
  }) async {
    final url = Uri.parse('${baseUrl}api/transaction/delete/$transactionId');
    try {
      final accessToken = await AuthService.getAccessToken();

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Deleted successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to delete transaction',
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
}
