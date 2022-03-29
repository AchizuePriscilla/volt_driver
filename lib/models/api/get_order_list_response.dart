import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt_driver/models/api/api_response.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'api_error_response.dart';

class GetOrderListResponse extends Equatable {
  final bool success;
  final OrderListModel? orders;
  final ApiErrorResponse? error;

  const GetOrderListResponse({
    this.success = false,
    this.error,
    this.orders,
  });

  factory GetOrderListResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetOrderListResponse(error: failure.error),
      (success) => GetOrderListResponse(
        success: true,
        orders: OrderListModel.fromMap(success.data),
      ),
    );
  }

  @override
  List<Object?> get props => [success, error, orders];
}
