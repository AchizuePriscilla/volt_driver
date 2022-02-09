import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt_driver/models/api/api_response.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'api_error_response.dart';

class GetAssignedOrdersResponse extends Equatable {
final bool success;
  final OrderListModel? orders;
  final ApiErrorResponse? error;

  const GetAssignedOrdersResponse({
    this.success = false,
    this.error,
    this.orders,
  });

  factory GetAssignedOrdersResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetAssignedOrdersResponse(error: failure.error),
      (success) => GetAssignedOrdersResponse(
        success: true,
        orders: OrderListModel.fromJson(success.data['orders'] ?? ""),
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        error,
        orders
      ];
  
}