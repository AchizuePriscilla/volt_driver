import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/api/general_response.dart';
import 'package:volt_driver/models/api/orders.dart';

abstract class OrderRepo {
  Future<GetOrdersResponse> getAssignedOrders();
  Future<GetOrdersResponse> getAllOrders();
  Future<GeneralResponse> updateOrderStatus(
      {required String orderId, required String status});
  Future<GeneralResponse> assignOrder(String orderId);
}

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);

  static const String driverOrders = 'order/logistics';
  static const String orders = 'order/available';
  static const String order = 'logistics/order';
  static const String assign = 'logistics/pickup';

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

  @override
  Future<GeneralResponse> updateOrderStatus(
      {required String orderId, required String status}) async {
    var res = await patch(order, data: {"orderID:": orderId, "status": status});
    return GeneralResponse.fromMap(res);
  }

  @override
  Future<GeneralResponse> assignOrder(String orderId) async {
    var res = await post(assign, data: {"orderID": orderId});
    return GeneralResponse.fromMap(res);
  }
}
