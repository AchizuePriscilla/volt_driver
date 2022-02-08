import 'package:equatable/equatable.dart';
import 'package:volt_driver/utils/enums.dart';

class ApiErrorResponse extends Equatable {
  final ErrorType type;
  final String message;

  const ApiErrorResponse({
    this.type = ErrorType.unknown,
    required this.message,
  });

  @override
  List<Object?> get props => [type, message];
}