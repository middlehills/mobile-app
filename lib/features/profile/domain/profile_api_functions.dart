class ProfileApiFunctions {
  ProfileApiFunctions._();

  //   static Future<ApiResponse> addSingleRecord({
  //   required String baseUrl,
  //   required String hashPassword,

  // }) async {
  //   final url = Uri.parse('${baseUrl}api/transaction/add/');
  //   try {
  //     final accessToken = await AuthService.getAccessToken();
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //       body: jsonEncode(uploadData),
  //     );

  //     if (response.statusCode == 201) {
  //       final data = jsonDecode(response.body);
  //       return ApiResponse(
  //         message: data['success'] ?? 'Saved transaction successfully',
  //         data: data,
  //         statusCode: response.statusCode,
  //         responsePhrase: response.reasonPhrase ?? '',
  //       );
  //     } else {
  //       final data = jsonDecode(response.body);
  //       return ApiResponse(
  //         message: data['error'] ?? 'Failed to save transaction',
  //         data: jsonDecode(response.body),
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
}
