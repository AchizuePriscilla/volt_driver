
import 'package:volt_driver/models/api/api.dart';
import 'package:volt_driver/utils/utils.dart';

abstract class ApiResponse {}

class Success extends ApiResponse {
  final Map<String, dynamic> data;

  Success(this.data);
}

class Failure extends ApiResponse {
  final ApiErrorResponse error;

  Failure(this.error);

  factory Failure.fromMap(Map<String, dynamic> json) {
    return Failure(
      ApiErrorResponse(
        message: getErrorMessage(json['message']),
        type: json['data'] != null
            ? getErrorType(json['data']['errorType'])
            : ErrorType.unknown,
      ),
    );
  }

  static String getErrorMessage(Object message) {
    if (message is List && message.isNotEmpty) {
      return message.first;
    }
    if (message is String) return message;
    return "Unknown error";
  }

  static ErrorType getErrorType(String? error) {
    switch (error) {
      case 'emailNotVierified':
        return ErrorType.emailNotVerified;
      case 'userNotFound':
        return ErrorType.userNotFound;
      case 'emailAlreadyValidated':
        return ErrorType.emailAlreadyValidated;
      case 'emailNotValidated':
        return ErrorType.emailNotValidated;
      case 'emailExists':
        return ErrorType.emailExists;
      default:
        return ErrorType.unknown;
    }
  }
}