import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt_driver/models/api/api_response.dart';
import 'package:volt_driver/models/directions_model.dart';
import 'api_error_response.dart';

class GetDirectionResponse extends Equatable {
  final bool success;
  final DirectionModel? directionModel;
  final ApiErrorResponse? error;

  const GetDirectionResponse({
    this.success = false,
    this.error,
    this.directionModel,
  });

  factory GetDirectionResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetDirectionResponse(error: failure.error),
      (success) => GetDirectionResponse(
        success: true,
        directionModel: DirectionModel.fromMap(success.data),
      ),
    );
  }

  @override
  List<Object?> get props => [success, error, directionModel];
}
