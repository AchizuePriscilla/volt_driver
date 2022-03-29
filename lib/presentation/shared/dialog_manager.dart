import 'package:flutter/material.dart';
import 'package:volt_driver/handlers/dialog_handler.dart';
import 'package:volt_driver/models/dialog/dialog_request.dart';
import 'package:volt_driver/presentation/shared/dialog_card.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/utils/utils.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({Key? key, required this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  OverlayEntry? _overlayEntry;
  late DialogHandler _dialogHandler;

  @override
  void initState() {
    super.initState();
    _dialogHandler = locator<DialogHandler>();
    _dialogHandler.registerDialogListener(_showDialog);
    _dialogHandler.registerDismissDialogListener(_dismissDialog);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _dialogHandler = locator<DialogHandler>();
      _dialogHandler.registerDialogListener(_showDialog);
      _dialogHandler.registerDismissDialogListener(_dismissDialog);
    });
  }

  void _showDialog(DialogRequest request) {
    _overlayEntry = _createOverlayEntry(request);
    if (_overlayEntry != null) {
      Overlay.of(context)!.insert(_overlayEntry!);

      //dismiss dialog after [duration] if [autoDismiss] is true
      if (request.autoDismiss) {
        Future.delayed(request.duration).then(
          (value) => _dismissDialog(),
        );
      }
    }
  }

  void _dismissDialog([Object status = false]) {
    if (_overlayEntry != null) {
      _dialogHandler.dialogComplete(status);
      _overlayEntry!.remove();
    }
  }

  OverlayEntry _createOverlayEntry(DialogRequest request) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width,
        child: getDialogCard(request),
      ),
    );
  }

  Widget getDialogCard(DialogRequest request) {
    switch (request.dialogContentType) {
      case DialogContentType.success:
        return SuccessDialog(
          request: request,
          dismissDialog: (status) => _dismissDialog(true),
        );

      case DialogContentType.error:
        return ErrorDialog(
          request: request,
          dismissDialog: (status) => _dismissDialog(true),
        );

      default:
        return DialogCard(
          request: request,
          dismissDialog: (status) => _dismissDialog(status),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
