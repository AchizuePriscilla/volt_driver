import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt_driver/models/api/api_response.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'api_error_response.dart';

class GetOrderResponse extends Equatable {
  final bool success;
  final OrderModel? order;
  final ApiErrorResponse? error;

  const GetOrderResponse({
    this.success = false,
    this.error,
    this.order,
  });

  factory GetOrderResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetOrderResponse(error: failure.error),
      (success) => GetOrderResponse(
        success: true,
        order: OrderModel.fromMap(success.data['order']),
      ),
    );
  }

  @override
  List<Object?> get props => [success, error, order];
}
