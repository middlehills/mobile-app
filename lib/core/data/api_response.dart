class ApiResponse {
  final String? message;
  final Map<String, dynamic>? data;
  final int? statusCode;
  final String? responsePhrase;

  ApiResponse({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.responsePhrase,
  });
}
