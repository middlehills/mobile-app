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

  static Future<ApiResponse> checkPin({
    required String baseUrl,
    required String pin,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/check-pin/');
    final uploadData = {
      "pin": pin,
    };
    try {
      final accessToken = await AuthService.getAccessToken();
      final response = await http.post(
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
          message: data['success'] ?? 'PIN check successful',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'PIN check failed',
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
    final url = Uri.parse('${baseUrl}api/user/change-pin/');
    final uploadData = {
      "otp_code": otpCode,
      "newPin": newPin,
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
        return ApiResponse(
          message: data['success'] ?? 'PIN changed successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Change PIN failed',
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

  // static Future<ApiResponse> changePin({
  //   required String baseUrl,
  //   required String curPin,
  //   required String hashedPin,
  //   required String newPin,
  // }) async {
  //   final url = Uri.parse('${baseUrl}api/user/change-pin/');
  //   final uploadData = {
  //     "curPin": curPin,
  //     "hashedPin": hashedPin,
  //     "newPin": newPin,
  //   };
  //   try {
  //     final accessToken = await AuthService.getAccessToken();
  //     final response = await http.patch(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //       body: jsonEncode(uploadData),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return ApiResponse(
  //         message: data['success'] ?? 'PIN changed successfully',
  //         data: data,
  //         statusCode: response.statusCode,
  //         responsePhrase: response.reasonPhrase ?? '',
  //       );
  //     } else {
  //       final data = jsonDecode(response.body);
  //       return ApiResponse(
  //         message: data['error'] ?? 'Change PIN failed',
  //         data: data,
  //         statusCode: response.statusCode,
  //         responsePhrase: response.reasonPhrase ?? '',
  //       );
  //     }
  //   } on SocketException {
  //     return ApiResponse(
  //       message: 'No Internet connection.',
  //       data: null,
  //       statusCode: null,
  //       responsePhrase: '',
  //     );
  //   } on FormatException {
  //     return ApiResponse(
  //       message: 'Unable to parse response.',
  //       data: null,
  //       statusCode: null,
  //       responsePhrase: '',
  //     );
  //   } on HttpException {
  //     return ApiResponse(
  //       message: 'Could not find the server.',
  //       data: null,
  //       statusCode: null,
  //       responsePhrase: '',
  //     );
  //   } catch (e) {
  //     return ApiResponse(
  //       message: 'Error occurred: $e',
  //       data: null,
  //       statusCode: null,
  //       responsePhrase: '',
  //     );
  //   }
  // }

  static Future<ApiResponse> deleteAccount({
    required String baseUrl,
    required String otp,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/delete-account');
    try {
      final accessToken = await AuthService.getAccessToken();
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            'otp': otp,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'Account deleted successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Delete account failed',
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

  static Future<ApiResponse> getUserDetails({
    required String baseUrl,
  }) async {
    final url = Uri.parse('${baseUrl}api/user/details');
    try {
      final accessToken = await AuthService.getAccessToken();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['success'] ?? 'User details fetched successfully',
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Failed to fetch user details',
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

  static Future<ApiResponse> authMono({
    required String baseUrl,
    required String code,
  }) async {
    final url = Uri.parse('${baseUrl}api/connect-mono');
    final uploadData = {
      "code": code,
    };
    try {
      final accessToken = await AuthService.getAccessToken();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(uploadData),
      );

      log(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: (data['success'] ?? 'Mono authentication successful') == true
              ? 'Mono authentication successful'
              : (data['success'] ?? 'Mono authentication successful'),
          data: data,
          statusCode: response.statusCode,
          responsePhrase: response.reasonPhrase ?? '',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['error'] ?? 'Mono authentication failed',
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
