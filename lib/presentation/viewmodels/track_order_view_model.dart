import 'package:volt_driver/models/dialog/dialog_request.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class TrackOrderVM extends BaseViewModel {
  void showPickedUpDialog() {
    dialogHandler.showDialog(
        dismissable: true,
        contentType: DialogContentType.pickedUp,
        message: 'Picked Up');
  }
}
