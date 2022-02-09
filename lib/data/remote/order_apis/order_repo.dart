import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/api/orders.dart';

abstract class OrderRepo {
  Future<GetAssignedOrdersResponse> getAssignedOrders();
}

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);

  static const String driverOrders = 'order/logistics';

  @override
  Future<GetAssignedOrdersResponse> getAssignedOrders() async {
    var response = await get(driverOrders);
    return GetAssignedOrdersResponse.fromMap(response);
  }
}
