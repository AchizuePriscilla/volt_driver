import 'package:volt_driver/data/remote/order_apis/order_repo.dart';
import 'package:volt_driver/models/api/orders.dart';

abstract class OrderService {
  Future<GetAssignedOrdersResponse> getAssignedOrders();
}

class OrderServiceImpl implements OrderService {
  final OrderRepo orderRepo;

  OrderServiceImpl({required this.orderRepo});

  @override
  Future<GetAssignedOrdersResponse> getAssignedOrders() async {
    var res = await orderRepo.getAssignedOrders();
    return res;
  }
}
