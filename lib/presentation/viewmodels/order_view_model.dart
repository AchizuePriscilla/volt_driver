import 'package:volt_driver/models/navigation/pickup_details_args.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/utils.dart';

class OrderVM extends BaseViewModel {
  late OrderListModel assignedOrders;
  late OrderListModel allOrders;

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

  Future<void> updateOrderStatus(
      {required String orderId, required String status}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      await orderService.updateOrderStatus(orderId: orderId, status: status);
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> assignOrder(Order order) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.assignOrder(order.id);
      if (res.success) {
        navigationHandler.popAndPushNamed(trackOrderViewRoute,
            arg: PickupDetailsArgs(order));
      } else {
        dialogHandler.showDialog(
            contentType: DialogContentType.error, message: res.error!.message);
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<List<Order>> getAllOrders() async {
    try {
      var res = await orderService.getAllOrders();
      allOrders = res.orders!;
      return allOrders.orders;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }
}
