class DialogRequest {
  final DialogContentType dialogContentType;
  final String title;
  final String buttonText;
  final String message;
  final String? imagePath;
  final bool autoDismiss;
  final bool dismissable;
  final Duration duration;
  final String? warningMessage;
  final String? primaryText;
  final String? secondaryText;
  final bool outlineButtons;

  DialogRequest({
    this.dialogContentType = DialogContentType.success,
    required this.title,
    required this.buttonText,
    required this.message,
    this.imagePath,
    this.dismissable = true,
    this.autoDismiss = false,
    this.duration = const Duration(seconds: 3),
    this.warningMessage,
    this.primaryText,
    this.secondaryText,
    this.outlineButtons = false,
  });
}

enum DialogContentType { success, transactionComplete, pickedUp }
