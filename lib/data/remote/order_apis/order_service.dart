import 'package:volt_driver/data/remote/order_apis/order_repo.dart';
import 'package:volt_driver/models/api/orders.dart';

import '../../../models/api/general_response.dart';

abstract class OrderService {
  Future<GetOrdersResponse> getAssignedOrders();
  Future<GetOrdersResponse> getAllOrders();
  Future<GeneralResponse> updateOrderStatus(
      {required String orderId, required String status});
  Future<GeneralResponse> assignOrder(String orderId);
}

class OrderServiceImpl implements OrderService {
  final OrderRepo orderRepo;

  OrderServiceImpl({required this.orderRepo});

  @override
  Future<GetOrdersResponse> getAssignedOrders() async {
    var res = await orderRepo.getAssignedOrders();
    return res;
  }

  @override
  Future<GetOrdersResponse> getAllOrders() async {
    var res = await orderRepo.getAllOrders();
    return res;
  }

  @override
  Future<GeneralResponse> updateOrderStatus(
      {required String orderId, required String status}) async {
    var res =
        await orderRepo.updateOrderStatus(orderId: orderId, status: status);
    return res;
  }

  @override
  Future<GeneralResponse> assignOrder(String orderId) async {
    var res = await orderRepo.assignOrder(orderId);
    return res;
  }
}
