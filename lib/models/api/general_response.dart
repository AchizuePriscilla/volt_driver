import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'api_error_response.dart';
import 'api_response.dart';

class GeneralResponse extends Equatable {
  final bool success;
  final String message;
  final ApiErrorResponse? error;

  const GeneralResponse({
    this.success = false,
    this.message = '',
    this.error,
  });

  factory GeneralResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GeneralResponse(error: failure.error),
      (success) => GeneralResponse(
        success: true,
        message: success.data['message'] ?? "",
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        message,
        error,
      ];
}
