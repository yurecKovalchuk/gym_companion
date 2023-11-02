import '../models/models.dart';

class ValidationException implements Exception {
  ValidationException(
    this.response,
  );

  final ErrorResponse response;
}
