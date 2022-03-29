import 'dart:developer';

import 'package:volt_driver/models/navigation/pickup_details_args.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/models/user_model.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/utils.dart';

class OrderVM extends BaseViewModel {
  late OrderListModel assignedOrders;
  late OrderListModel allOrders;
  late UserModel _user;
  late OrderModel _rxOrder;
  UserModel get user => _user;
  OrderModel get order => _rxOrder;

  void showPickedUpDialog() {
    dialogHandler.showDialog(
        dismissable: true,
        contentType: DialogContentType.pickedUp,
        message: 'Picked Up');
  }

  Future<void> getUserById(String id) async {
    try {
      toggleLoading(true);
      var user = await authService.getUserById(id);
      _user = user.user!;
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<List<OrderModel>> getAssignedOrders() async {
    try {
      var res = await orderService.getAssignedOrders();
      assignedOrders = res.orders!;
      return assignedOrders.orders;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }

  Future<bool> getOrderById(String id) async {
    try {
      var order = await orderService.getOrderById(id);
      _rxOrder = order.order!;
      if (order.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      AppLogger.logger.d(e);
      return false;
    }
  }

  Future<void> updateOrderStatus(
      {required String orderId, required String status}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.updateOrderStatus(
          orderId: orderId, status: status);
      if (res.success) {
        await getOrderById(orderId);
        if (status == 'DELIVERED') {
          showPickedUpDialog();
        }
      } else {
        dialogHandler.showDialog(contentType: DialogContentType.error);
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> assignOrder(OrderModel order) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.assignOrder(order.id);
      if (res.success) {
        var user = await authService.getUserById(order.createdBy);
        _user = user.user!;
        navigationHandler.popAndPushNamed(trackOrderViewRoute,
            arg: PickupDetailsArgs(order: order));
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

  Future<List<OrderModel>> getAllOrders() async {
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
