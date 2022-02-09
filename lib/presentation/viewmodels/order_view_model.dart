import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/utils.dart';

class OrderVM extends BaseViewModel {
  late OrderListModel assignedOrders;

  void showPickedUpDialog() {
    dialogHandler.showDialog(
        dismissable: true,
        contentType: DialogContentType.pickedUp,
        message: 'Picked Up');
  }

  Future<List<Order>> getAssignedOrders() async {
    try {
      var res = await orderService.getAssignedOrders();
      assignedOrders = res.orders!;
      return assignedOrders.orders;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }
}
