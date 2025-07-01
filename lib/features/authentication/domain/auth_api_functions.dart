import 'dart:developer';

import 'package:mid_hill_cash_flow/core/data/api_response.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mid_hill_cash_flow/features/authentication/data/user_reg_data.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_service.dart';

class AuthApiFunctions {
  AuthApiFunctions._();

  static Future<ApiResponse> signUp({
    required String baseUrl,
    required UserRegData userRegData,
    required String pin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/signup');

    String body = jsonEncode({
      "first_name": userRegData.firstName,
      "last_name": userRegData.lastName,
      "phone_number": userRegData.phoneNumber,
      "pin": pin,
    });
    log(body);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Sign up successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to sign up',
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

  static Future<ApiResponse> signIn({
    required String baseUrl,
    required String phoneNumber,
    required String pin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/signin');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phone_number": phoneNumber,
          "pin": pin,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Login successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to sign in',
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

  static Future<ApiResponse> login({
    required String baseUrl,
    required String phoneNumber,
    required String pin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phone_number": phoneNumber,
          "pin": pin,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Login successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to login',
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

  static Future<ApiResponse> verifySignUp({
    required String baseUrl,
    required String id,
    required String otp,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/verify-signup');
    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": id,
          "otp": otp,
        }),
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
          message: data['error'] ?? 'Failed to verify sign up',
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

  static Future<ApiResponse> resendOtp({
    required String baseUrl,
    required String id,
  }) async {
    final url = Uri.parse('${baseUrl}api/otp/resend/$id');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      log(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'OTP resent successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to resend OTP',
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

  static Future<ApiResponse> forgotPin({
    required String baseUrl,
    required String phoneNumber,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/forgot-pin');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phone_number": phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Forgot PIN request successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to request forgot PIN',
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

  static Future<ApiResponse> changePin({
    required String baseUrl,
    required String otpCode,
    required String newPin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/change-pin');

    final accessToken = await AuthService.getAccessToken();

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "otp_code": otpCode,
          "newPin": newPin,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Pin changed successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to change pin',
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

  static Future<ApiResponse> verifyOtp({
    required String baseUrl,
    required String otp,
    required String userId,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/verify-otp/');

    // final accessToken = AuthService.getAccessToken();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "otp": otp,
          "id": userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'OTP verified successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to verify OTP',
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
