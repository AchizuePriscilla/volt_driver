import 'dart:async';
import 'dart:developer';
import 'package:volt_driver/models/dialog/dialog_request.dart';

abstract class DialogHandler {
  ///Sets the visibility of a dialog
  void setIsDialogVisible(bool isDialogVisible);

  ///Dismisses a dialog or loader
  void dismissDialog();

  ///Stops a loader
  void stopLoader();

  /// Registers a callback function to show a dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener);

  ///Registers a callback to dismiss a dialog
  void registerDismissDialogListener(Function dismissCurrentDialog);

  ///Regsiters a callback to complete the completer
  void dialogComplete(Object response);

  bool get isDialogVisible;

  bool get isLoaderVisible;

  ///Displays a dialog on the screen
  Future<Object> showDialog({
    DialogContentType contentType = DialogContentType.success,
    String message = '',
    String title = '',
    bool autoDismiss = false,
    bool dismissable = true,
    Duration duration = const Duration(seconds: 3),
    String? warningMessage,
    String? primaryText,
    String? secondaryText,
    bool outlineButtons = false,
  });

  ///Displays a loader
  // Future<Object> showLoader();
}

class DialogHandlerImpl implements DialogHandler {
  late Function(DialogRequest) _showDialogListener;
  late Completer<Object> _dialogCompleter;
  late Function _dismissCurrentDialog;

  Completer<Object> get dialogCompleter => _dialogCompleter;

  bool _isDialogVisible = false;
  bool _isLoaderVisible = false;

  /// Boolean reference which can be used to look up whether a dialog is on screen or not.
  @override
  bool get isDialogVisible => _isDialogVisible;

  /// Boolean reference which can be used to look up whether a loader is on screen or not.
  @override
  bool get isLoaderVisible => _isLoaderVisible;

  @override
  void setIsDialogVisible(bool isDialogVisible) {
    _isDialogVisible = isDialogVisible;
  }

  @override
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Registers a callback function to dismiss the dialog
  @override
  void registerDismissDialogListener(Function dismissCurrentDialog) {
    _dismissCurrentDialog = dismissCurrentDialog;
  }

  /// Dismisses the dialog
  @override
  void dismissDialog() {
    _dismissCurrentDialog();
  }

  ///Dismisses any visible dialog
  void _closeVisibleDialog() {
    if (isDialogVisible) {
      dismissDialog();
    }
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  ///
  /// If primaryText and seondaryText are both non null,
  /// `true` is returned when the button containing the primaryText is tapped.
  /// `false` is returned when the button containing the secondaryText is tapped.
  @override
  Future<Object> showDialog({
    DialogContentType contentType = DialogContentType.success,
    String message = '',
    String title = '',
    String buttonText = 'Close',
    bool dismissable = true,
    bool autoDismiss = false,
    String imagePath = 'order_placed',
    Duration duration = const Duration(seconds: 3),
    String? primaryText,
    String? warningMessage,
    String? secondaryText,
    bool outlineButtons = false,
  }) {
    _dialogCompleter = Completer<Object>();
    _closeVisibleDialog();
    _showDialogListener(
      DialogRequest(
          title: title,
          message: message,
          dialogContentType: contentType,
          warningMessage: warningMessage,
          primaryText: primaryText,
          secondaryText: secondaryText,
          outlineButtons: outlineButtons,
          duration: duration,
          autoDismiss: autoDismiss,
          dismissable: dismissable,
          buttonText: buttonText,
          imagePath: imagePath),
    );

    _isDialogVisible = true;
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  @override
  void dialogComplete(Object response) {
    _isDialogVisible = false;
    _dialogCompleter.complete(response);
    _dialogCompleter = Completer<Object>();
  }

  // @override
  // Future<Object> showLoader() async {
  //   _isLoaderVisible = true;
  //   return await showDialog(contentType: DialogContentType.success);
  // }

  @override
  void stopLoader() {
    try {
      _isLoaderVisible = false;
      dismissDialog();
    } catch (e) {
      log(e.toString());
    }
  }
}
