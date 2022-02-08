import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/enums.dart';

class TrackOrderVM extends BaseViewModel {
  void showPickedUpDialog() {
    dialogHandler.showDialog(
        dismissable: true,
        contentType: DialogContentType.pickedUp,
        message: 'Picked Up');
  }
}
