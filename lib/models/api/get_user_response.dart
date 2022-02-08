import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt_driver/models/api/api.dart';
import 'package:volt_driver/models/user_model.dart';

class GetUserResponse extends Equatable {
  final bool success;
  final UserModel? user;
  final ApiErrorResponse? error;

  const GetUserResponse({
    this.success = false,
    this.error,
    this.user,
  });

  factory GetUserResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetUserResponse(error: failure.error),
      (success) => GetUserResponse(
        success: true,
        user: UserModel.fromJson(success.data['user'] ?? ""),
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        error,
        user
      ];
}
