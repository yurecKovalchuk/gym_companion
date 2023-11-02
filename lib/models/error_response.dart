class ErrorResponse {
  ErrorResponse(
    this.message,
    this.error,
    this.statusCode,
  );

  final dynamic message;
  final String? error;
  final int? statusCode;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    final dynamic rawMessage = json['message'];

    return ErrorResponse(
      (rawMessage is List) ? List<String>.from(rawMessage) : rawMessage,
      json['error'],
      json['statusCode'],
    );
  }
}
