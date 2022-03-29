import 'package:volt_driver/data/remote/order_apis/order_repo.dart';
import 'package:volt_driver/models/api/get_order_list_response.dart';
import 'package:volt_driver/models/api/get_order_response.dart';

import '../../../models/api/general_response.dart';

abstract class OrderService {
  Future<GetOrderListResponse> getAssignedOrders();
  Future<GetOrderListResponse> getAllOrders();
  Future<GetOrderResponse> getOrderById(String id);
  Future<GeneralResponse> updateOrderStatus(
      {required String orderId, required String status});
  Future<GeneralResponse> assignOrder(String orderId);
}

class OrderServiceImpl implements OrderService {
  final OrderRepo orderRepo;

  OrderServiceImpl({required this.orderRepo});

  @override
  Future<GetOrderListResponse> getAssignedOrders() async {
    var res = await orderRepo.getAssignedOrders();
    return res;
  }

  @override
  Future<GetOrderListResponse> getAllOrders() async {
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

  @override
  Future<GetOrderResponse> getOrderById(String id) async {
    var res = await orderRepo.getOrderById(id);
    return res;
  }
}
