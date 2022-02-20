import 'package:volt_driver/data/remote/order_apis/order_repo.dart';
import 'package:volt_driver/models/api/orders.dart';

abstract class OrderService {
  Future<GetOrdersResponse> getAssignedOrders();
  Future<GetOrdersResponse> getAllOrders();
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
}
