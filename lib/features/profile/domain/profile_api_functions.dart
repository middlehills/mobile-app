import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_service.dart';
import 'package:http/http.dart' as http;

class ProfileApiFunctions {
  ProfileApiFunctions._();

  static Future<ApiResponse> updateUserDetails({
    required String baseUrl,
    required String pin,
    required String hashedPin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/edit-profile/');
    final uploadData = {
      "pin": pin,
      "hashedPin": hashedPin,
    };
    try {
      final accessToken = await AuthService.getAccessToken();
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(uploadData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Successful operation',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Update pin failed',
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

  static Future<ApiResponse> verifyEditProfile({
    required String baseUrl,
    required String userId,
    required String otpCode,
    required Map<String, String> body,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/verify-edit/');

    final uploadData = {
      "otp_code": otpCode,
    };

    uploadData.addAll(body);
    try {
      final accessToken = await AuthService.getAccessToken();
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(uploadData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Verification successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Verification failed',
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
