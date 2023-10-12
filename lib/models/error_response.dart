class ErrorResponse {
  ErrorResponse(
    this.message,
    this.error,
    this.statusCode,
  );

  final List<String?> message;
  final String? error;
  final int? statusCode;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      List<String>.from(json['message']),
      json['error'],
      json['statusCode'],
    );
  }
}
