import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/api/orders.dart';

abstract class OrderRepo {
  Future<GetOrdersResponse> getAssignedOrders();
  Future<GetOrdersResponse> getAllOrders();
}

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);

  static const String driverOrders = 'order/logistics';
  static const String orders = 'order/available';

  @override
  Future<GetOrdersResponse> getAssignedOrders() async {
    var response = await get(driverOrders);
    return GetOrdersResponse.fromMap(response);
  }

  @override
  Future<GetOrdersResponse> getAllOrders() async {
    var response = await get(orders);
    return GetOrdersResponse.fromMap(response);
  }
}
